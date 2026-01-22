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

        print(f"Analyst: {analyst.analyst_name} (Role: {analyst.role})")
        print(f"Direct Results (analyst.clients.all()): {analyst.clients.count()}")
        for c in analyst.clients.all():
            print(f" - {c.client_name} (ID: {c.id})")
        
        # Find teams he leads
        led_teams = Team.objects.filter(team_lead=analyst)
        print(f"\nLed Teams: {led_teams.count()}")
        for t in led_teams:
            print(f" Team: {t.name} (ID: {t.id})")
            print(f" Team Clients: {t.clients.count()}")
            for c in t.clients.all():
                print(f"  - {c.client_name} (ID: {c.id})")
        
        # Find teams he is a member of
        member_teams = analyst.teams.all()
        print(f"\nMember Teams: {member_teams.count()}")
        for t in member_teams:
             print(f" Team: {t.name} (ID: {t.id})")
    
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    inspect_data()
