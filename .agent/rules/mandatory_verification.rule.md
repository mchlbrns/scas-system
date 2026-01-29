---
description: Enforce mandatory verification for all code changes, specifically requiring browser-based testing for UI modifications.
globs: "**/*"
---
# Mandatory Verification Rule

## Description
To ensure high code quality and prevent regressions, this rule mandates that ALL code changes must be verified before a task is considered complete. Specifically for frontend/UI changes, the use of the `browser_subagent` is REQUIRED to validate the implementation visually and functionally.

## Triggers
- Any task involving `EXECUTION` mode where code is modified.
- User requests to "fix", "feature", "update", or "refactor".
- Creation or modification of `.tsx`, `.css`, or frontend-related files.

## Actions

### 1. Identify Verification Type
- **Frontend/UI Changes:** MUST use `browser_subagent`.
- **Backend/API Changes:** MUST use `run_command` (curl, pytest) or `browser_subagent` (if verifiable via UI).
- **Logic/Library Changes:** MUST run unit tests or create a reproduction script.

### 2. Browser Verification Protocol (For UI)
When modifying the UI:
1.  **Launch Browser:** Use `browser_subagent` to open the relevant local URL (e.g., `http://localhost:3000`).
2.  **Navigate & Interact:** Instruct the subagent to click, type, and navigate to the modified feature.
3.  **Verify State:** Assert that the expected state is visible (e.g., "The user list is displayed", "The error message is gone").
4.  **Capture Evidence:** The subagent automatically records the session. You may also explicitly ask it to check specific DOM elements.

### 3. Proof of Work
- Every verification step must be documented in the `walkthrough.md` or final report.
- "I tested it" is NOT sufficient. Evidence (logs, screenshot descriptions, or successful tool outputs) is required.

## Examples

### ✅ Correct Usage
User: "Fix the login button color."
Agent:
1. Modifies `Login.tsx`.
2. Calls `browser_subagent`: "Go to /login, check if the button is now blue, and click it to ensure it still works."
3. Agent sees success from subagent.
4. Updates `walkthrough.md` with "Verified login button color and functionality via browser test."

### ❌ Incorrect Usage
User: "Fix the login button color."
Agent:
1. Modifies `Login.tsx`.
2. Says: "I fixed it. Please check." (SKIPPED VERIFICATION)

### ❌ Incorrect Usage
User: "Add a new API endpoint."
Agent:
1. Adds endpoint code.
2. Says: "Done." (SKIPPED VERIFICATION - should have curled the endpoint)
