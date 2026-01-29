import json
from django.test import TestCase, RequestFactory
from django.contrib.auth.models import User
from core.middleware import AuditLogMiddleware
from core.models import AuditLog

class MockResponse:
    def __init__(self):
        self.status_code = 200

class AuditLogMiddlewareTest(TestCase):
    def setUp(self):
        self.factory = RequestFactory()
        self.user = User.objects.create_user(username='testuser', password='password123')
        self.middleware = AuditLogMiddleware(lambda request: MockResponse())

    def test_log_excludes_password_json(self):
        # Create a POST request with sensitive JSON data
        data = {
            'username': 'testuser',
            'password': 'secretpassword',
            'new_password': 'newsecretpassword',
            'nested': {
                'token': 'secrettoken'
            }
        }
        request = self.factory.post(
            '/api/change-password/',
            data=json.dumps(data),
            content_type='application/json'
        )
        request.user = self.user
        
        # Mock response/view processing
        response = self.middleware(request)
        
        # Check Audit Log
        log = AuditLog.objects.last()
        self.assertIsNotNone(log)
        
        # Assert Replacement, not just Redaction
        self.assertEqual(log.details['body']['message'], 'Password processed successfully')
        self.assertNotIn('password', log.details['body'])
        self.assertNotIn('new_password', log.details['body'])

    def test_log_excludes_password_form(self):
        # Create a POST request with sensitive Form data
        data = {
            'username': 'testuser',
            'password': 'secretpassword'
        }
        request = self.factory.post(
            '/api/login/',
            data=data
        )
        request.user = self.user
        
        response = self.middleware(request)
        
        log = AuditLog.objects.last()
        self.assertIsNotNone(log)
        
        self.assertEqual(log.details['body']['password'], '[REDACTED]')
        self.assertEqual(log.details['body']['username'], 'testuser')

    def test_log_delete_action(self):
        # Create a DELETE request
        request = self.factory.delete('/api/analysts/123/')
        request.user = self.user
        
        self.middleware(request)
        
        log = AuditLog.objects.last()
        self.assertIsNotNone(log)
        self.assertEqual(log.action, 'DELETE')
        # CURRENT BEHAVIOR: details['body'] might be missing or empty
        # We want to assert that it eventually contains a success message
        # For now, let's just inspect it or assert what we want to build
        self.assertIn('body', log.details)
        self.assertEqual(log.details['body']['message'], 'Record deleted successfully')

    def test_log_excludes_sensitive_query_params(self):
        request = self.factory.delete('/api/users/1/?token=secrettoken&safe=value')
        request.user = self.user
        
        self.middleware(request)
        
        log = AuditLog.objects.last()
        token_val = log.details['query_params']['token']
        self.assertTrue(token_val == '[REDACTED]' or token_val == ['[REDACTED]'], f"Token not redacted properly. Actual: {token_val}")
        
        safe_val = log.details['query_params']['safe']
        self.assertTrue(safe_val == 'value' or safe_val == ['value'], f"Safe val incorrect. Actual: {safe_val}")
