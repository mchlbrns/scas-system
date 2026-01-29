import requests
import sys

BASE_URL = "http://localhost:8000"

def test_auth_endpoint():
    print(f"Testing {BASE_URL}/api/token/...")
    
    # Needs a valid user. I'll use the 'admin' user if it exists, or expect 401 with wrong credentials
    # but at least prove the endpoint exists and returns JSON.
    
    try:
        response = requests.post(f"{BASE_URL}/api/token/", json={
            "username": "admin",
            "password": "wrongpassword" # Intentional failure to check existence
        })
        
        print(f"Status Code: {response.status_code}")
        
        if response.status_code == 401:
            print("✅ Endpoint exists (Got 401 Unauthorized as expected for bad creds)")
        elif response.status_code == 200:
             print("✅ Endpoint works (Got 200 OK)")
        elif response.status_code == 404:
            print("❌ Endpoint NOT FOUND (404)")
            sys.exit(1)
        else:
            print(f"⚠️ Unexpected status: {response.status_code}")
            
    except requests.exceptions.ConnectionError:
        print("❌ Could not connect to server. Is it running?")
        sys.exit(1)

if __name__ == "__main__":
    test_auth_endpoint()
