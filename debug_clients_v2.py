import os
import django
import sys

# Setup Django environment
sys.path.append(os.getcwd())
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dcms.settings')
django.setup()

from analysts.models import Analyst
from teams.models import Team

def inspect_data():
    try:
        # Find Jay-Ar Rojas
        analyst = Analyst.objects.filter(analyst_name__icontains="Jay-Ar").first()
        if not analyst:
            print("Analyst 'Jay-Ar' not found.")
            return

        print(f"ANALYST: {analyst.analyst_name} (ID: {analyst.id})")
        print(f"Direct Client Count: {analyst.clients.count()}")
        print("Direct Clients:")
        all_clients = list(analyst.clients.all())
        seen = set()
        for c in all_clients:
            is_dup = c.id in seen
            seen.add(c.id)
            print(f" - {c.client_name} (ID: {c.id}) {'[DUPLICATE]' if is_dup else ''}")
        
        # Find teams he leads
        led_teams = Team.objects.filter(team_lead=analyst)
        print(f"\nLED TEAMS ({led_teams.count()}):")
        for t in led_teams:
            print(f" Team: {t.name} (ID: {t.id})")
            print(f" Team Client Count: {t.clients.count()}")
            for c in t.clients.all():
                print(f"  - {c.client_name} (ID: {c.id})")
    
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    inspect_data()
