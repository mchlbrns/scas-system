from django.db import models

class Client(models.Model):
    client_code = models.CharField(max_length=50, unique=True, null=True)  # Nullable first to allow migration of existing rows
    client_name = models.CharField(max_length=100)
    email = models.EmailField(null=True, blank=True)
    contact_person = models.CharField(max_length=100, null=True, blank=True)
    remarks = models.TextField(null=True, blank=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.client_code} - {self.client_name}" if self.client_code else self.client_name
