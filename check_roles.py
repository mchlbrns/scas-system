
import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dcms.settings')
django.setup()

from analysts.models import Analyst

counts = {}
for role, _ in Analyst.ROLE_CHOICES:
    counts[role] = Analyst.objects.filter(role=role).count()

print("Analyst Role Counts:", counts)

print("\nListing Team Leaders:")
for a in Analyst.objects.filter(role='TEAM_LEADER'):
    print(f"- {a.analyst_name} (Clients: {[c.client_name for c in a.clients.all()]})")
