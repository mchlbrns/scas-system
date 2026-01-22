import os
import django
import sys

# Setup Django environment
sys.path.append(os.getcwd())
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dcms.settings')
django.setup()

from analysts.models import Analyst
from teams.models import Team

def fix_duplicates():
    print("--- Checking Analysts for Duplicates ---")
    analysts = Analyst.objects.all()
    for analyst in analysts:
        clients = list(analyst.clients.all())
        unique_clients = set(clients)
        
        if len(clients) != len(unique_clients):
            print(f"Fixing Analyst: {analyst.analyst_name} (ID: {analyst.id})")
            print(f"  Count before: {len(clients)}")
            # .set() handles the deduplication automatically because it expects a list of unique objects or IDs
            # and clears the existing set before adding the new ones if we use clear=True implicity by set.
            # But the safer way to be explicit is to get distinct IDs.
            unique_ids = list(set([c.id for c in clients]))
            analyst.clients.set(unique_ids)
            print(f"  Count after: {analyst.clients.count()}")
        else:
            # print(f"  OK: {analyst.analyst_name}")
            pass

    print("\n--- Checking Teams for Duplicates ---")
    teams = Team.objects.all()
    for team in teams:
        clients = list(team.clients.all())
        unique_clients = set(clients)
        
        if len(clients) != len(unique_clients):
            print(f"Fixing Team: {team.name} (ID: {team.id})")
            print(f"  Count before: {len(clients)}")
            unique_ids = list(set([c.id for c in clients]))
            team.clients.set(unique_ids)
            print(f"  Count after: {team.clients.count()}")
        else:
            # print(f"  OK: {team.name}")
            pass

if __name__ == "__main__":
    fix_duplicates()
