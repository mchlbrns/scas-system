---
description: Enforces mandatory automatic testing for all new development tasks.
---

# Automatic Testing Rule

## Description
This rule ensures that every code modification is verified by an automated test. It mandates specific testing strategies based on the context of the change (Browser/Frontend vs. Backend/Core).

## Triggers
- Code modification (File Write/Edit).
- Task completion (prior to "Merge" or "Verify" steps).
- Explicit "Test" command.

## Actions

### 1. Context Detection
Analyze the `modified_files` list or the current active task:
- **Browser Context**: Includes `*.tsx`, `*.jsx`, `*.html`, `*.css`, or any file within `frontend/` or `public/`.
- **Core Context**: Includes `*.ts` (backend), `*.js` (scripts), `*.py`, `*.go`, or configuration files.

### 2. Enforcement Logic

#### IF Browser Context:
- **Requirement**: you MUST use the `browser_subagent` tool to verify the UI changes visually.
- **Requirement**: you MUST run frontend unit tests if logic is changed. 
- **Action**:
  - Launch `browser_subagent`.
  - Navigate to the relevant page (local or staging).
  - Verify visually (screenshot) or interactively that the change is correct.
  - Run `npm test` (Vitest) in `frontend/` to ensure no regressions.
  - **Constraint**: Do not rely solely on unit tests for UI changes, but do not skip them either.

#### IF Core Context:
- **Requirement**: You MUST run relevant unit/integration tests or create a reproduction script.
- **Action**:
  - Run existing tests: `pytest` (Backend) or `npm test` (Frontend Logic).
  - If new functionality: Create a new test case.
  - If bug fix: Create a reproduction script that fails before the fix and passes after.

## Examples

### Correct Usage (Browser)
> User: "Change button color to blue."
> Agent: *Modifies CSS* -> *Calls `browser_subagent` to open page and screenshot the blue button.*

### Correct Usage (Core)
> User: "Fix calculation logic in `utils.ts`."
> Agent: *Modifies `utils.ts`* -> *Runs `npm test -- utils.test.ts` to verify fix.*

### Incorrect Usage
> User: "Add new nav bar."
> Agent: *Modifies `Navbar.tsx`* -> *Says "Done" without launching browser to check.* (VIOLATION)
