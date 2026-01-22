import os
import django
import sys

sys.path.append(os.getcwd())
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dcms.settings')
django.setup()

from analysts.models import Analyst
from clients.models import Client

def remove_extra_client():
    try:
        analyst = Analyst.objects.get(analyst_name="Jay-Ar Rojas")
        bria = Client.objects.filter(client_name__icontains="Bria").first()
        
        if not bria:
            print("Client Bria not found.")
            return

        print(f"Analyst: {analyst.analyst_name} Client Count: {analyst.clients.count()}")
        
        if bria in analyst.clients.all():
            print(f"Removing {bria.client_name} (ID: {bria.id}) from Analyst...")
            analyst.clients.remove(bria)
            print(f"Removed. New Count: {analyst.clients.count()}")
        else:
            print(f"{bria.client_name} is not assigned to {analyst.analyst_name}.")

    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    remove_extra_client()
