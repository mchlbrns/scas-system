import json
from .models import AuditLog

class AuditLogMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Determine if we should log based on method (unsafe methods only)
        should_log = request.method in ['POST', 'PUT', 'PATCH', 'DELETE'] and not request.path.startswith('/api/auth/')
        
        request_body_data = None
        
        if should_log:
            # Capture body BEFORE view consumes it
            try:
                content_type = request.META.get('CONTENT_TYPE', '')
                
                # Handle JSON
                if 'application/json' in content_type:
                    # Accessing request.body here forces Django to read and cache it.
                    # This is safe because subsequent reads will use the cache.
                    if request.body:
                         if len(request.body) < 10000:
                             request_body_data = json.loads(request.body)
                         else:
                             request_body_data = "Body too large"
                
                # Handle Form Data
                elif 'multipart/form-data' in content_type or 'application/x-www-form-urlencoded' in content_type:
                    # For form data, we can't easily read 'body' without consuming the stream 
                    # in a way that might block request.POST later if not careful.
                    # However, accessing request.POST consumes the stream and populates POST/FILES.
                    # IF we do it here, the view will just use the already-populated POST.
                    # This is generally safe in Django.
                    request_body_data = {k: v for k, v in request.POST.items()}
                    
                # Fallback for other data types
                else:
                     if request.body:
                         try:
                             request_body_data = json.loads(request.body)
                         except:
                             request_body_data = request.body.decode('utf-8', errors='ignore')[:1000]

            except Exception as e:
                request_body_data = f"Error capturing body: {str(e)}"

        response = self.get_response(request)

        if should_log:
            self.log_action(request, response, request_body_data)

        return response

    def log_action(self, request, response, request_body_data):
        # Ignore Safe Gets/Options (Redundant check but good for safety if called directly)
        if request.method in ['GET', 'HEAD', 'OPTIONS']:
            return

        user = request.user if request.user.is_authenticated else None
        
        # Get Client IP
        x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
        if x_forwarded_for:
            ip = x_forwarded_for.split(',')[0]
        else:
            ip = request.META.get('REMOTE_ADDR')

        # Prepare details
        custom_details = getattr(request, '_audit_details', None)
        if custom_details is not None:
             details = custom_details
        else:
            details = {}
            if request_body_data:
                details['body'] = request_body_data

        # Capture Query Params
        if request.GET:
            details['query_params'] = dict(request.GET)
            
        details['status_code'] = response.status_code
        details['path'] = request.path

        # Determine Target Model involved
        path_parts = request.path.strip('/').split('/')
        target_model = "Unknown"
        
        # Map common paths to cleaner names
        target_map = {
            'clients': 'Client',
            'analysts': 'Analyst',
            'teams': 'Team',
            'users': 'User',
            'payments': 'Payment',
            'receivables': 'Receivable',
            'ptp': 'PTP',
            'targets': 'Target',
            'password-reset-requests': 'PasswordReset'
        }

        if len(path_parts) > 0:
            resource_segment = ""
            for part in reversed(path_parts):
                if part in target_map:
                    resource_segment = part
                    break
            
            if resource_segment:
                target_model = target_map[resource_segment]
            else:
                target_model = path_parts[-1] if not path_parts[-1].isdigit() else path_parts[-2]

        object_id = None
        if path_parts[-1].isdigit():
             object_id = path_parts[-1]

        # Redact Sensitive Data
        SENSITIVE_KEYS = {'password', 'new_password', 'old_password', 'token', 'access', 'refresh', 'secret', 'key', 'authorization'}

        def contains_sensitive_data(data):
            if isinstance(data, dict):
                for k, v in data.items():
                    if k.lower() in SENSITIVE_KEYS:
                        return True
                    if contains_sensitive_data(v):
                        return True
            elif isinstance(data, list):
                for item in data:
                    if contains_sensitive_data(item):
                        return True
            return False

        def redact_data(data):
            if isinstance(data, dict):
                redacted = {}
                for k, v in data.items():
                    if k.lower() in SENSITIVE_KEYS:
                        redacted[k] = '[REDACTED]'
                    else:
                        redacted[k] = redact_data(v)
                return redacted
            elif isinstance(data, list):
                return [redact_data(item) for item in data]
            else:
                return data

        # Apply redaction to details
        if 'body' in details:
            # Check for special case: Change/Reset Password only
            # We don't want to hide details for Login/Create, just redact them.
            is_password_change_endpoint = any(x in request.path for x in ['change-password', 'reset-password', 'set-password'])
            
            if is_password_change_endpoint and response.status_code < 400:
                details['body'] = {'message': 'Password processed successfully', 'hidden_fields': 'Credentials omitted for security'}
            else:
                details['body'] = redact_data(details['body'])

        # Fallback for DELETE or missing body actions
        if 'body' not in details and request.method == 'DELETE':
             details['body'] = {'message': 'Record deleted successfully'}

        if 'query_params' in details:
            details['query_params'] = redact_data(details['query_params'])

        AuditLog.objects.create(
            actor=user,
            action=getattr(request, '_audit_action', request.method),
            target_model=target_model,
            object_id=object_id,
            details=details,
            ip_address=ip
        )
