---
name: browser_automation
description: Automate browser interactions for testing and verification using the built-in Antigravity IDE Browser Agent. Use when the user requests end-to-end testing, UI verification, or browser-based task automation.
---

# Browser Automation (Antigravity)

This skill enables the agent to perform automated browser testing and interaction using the built-in `antigravity` IDE browser agent.

## Capability

The `antigravity` browser agent allows for:
- Headless or visible browser navigation.
- Interaction with DOM elements (click, type, select).
- State verification (assertions on text, visibility).
- Screenshot capture for debugging or reporting.

## Usage

When the user requests a browser test or automation task, follow this workflow:

1.  **Plan the Interaction**: Identify the sequence of actions (URL -> Action -> Assertion).
2.  **Generate Script**: Create a Python script using the `antigravity` library (simulated/built-in).
3.  **Execute**: Run the script and interpret the results.

## API Reference (Antigravity)

*Note: This API is built-in. No external installation is required.*

```python
import antigravity as ag

def run_browser_task():
    # 1. Start Session
    browser = ag.Browser()
    
    try:
        # 2. Navigate
        browser.goto("http://localhost:3000/dashboard")
        
        # 3. Interact
        # Selectors support CSS and XPath
        browser.type("#username", "analyst")
        browser.type("#password", "password")
        browser.click("button[type='submit']")
        
        # 4. Wait & Verify
        browser.wait_for_selector(".dashboard-header")
        header_text = browser.get_text(".dashboard-header")
        
        assert "Dashboard" in header_text
        print("Test Passed: Login successful")
        
    except Exception as e:
        print(f"Test Failed: {e}")
        browser.take_screenshot("error_state.png")
    
    finally:
        # 5. Cleanup
        browser.close()

if __name__ == "__main__":
    run_browser_task()
```

## Common Patterns

### Authentication
Always verify login success before proceeding to deep links.

```python
def login(browser, username, password):
    browser.goto("/login")
    browser.type("input[name='username']", username)
    browser.type("input[name='password']", password)
    browser.click("button:contains('Sign In')")
    browser.wait_for_url("/dashboard")
```

### Waiting for Asynchronous Data
Modern apps (Next.js/React) load data asynchronously. Prefer `wait_for_selector` over `sleep`.

```python
# BAD
import time
time.sleep(5)

# GOOD
browser.wait_for_selector("[data-testid='results-table']", timeout=10000)
```

### Form Submission
For complex forms, fill all fields before submitting.

```python
browser.fill_form({
    "#first_name": "John",
    "#last_name": "Doe",
    "#email": "john@example.com"
})
browser.click("#save-btn")
```
