import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dcms.settings')
django.setup()

from django.contrib.auth import get_user_model
User = get_user_model()
try:
    u = User.objects.get(username='admin')
    u.set_password('admin')
    u.save()
    print("Password updated successfully")
except User.DoesNotExist:
    print("User 'admin' not found")
except Exception as e:
    print(f"Error: {e}")
