---
description: # Safe Publish Workflow
---

# Safe Publish Workflow
Version: 1.0.0

Command: /publish

## Objective
Safely prepare and publish local changes by making all actions
explicit, reviewable, and reversible—while respecting vibe-first
development and legacy-safe mode.

This workflow NEVER acts without explicit approval.

---

## Step 1: Working Tree Inspection
Inspect the current git state:
- Modified files
- New files
- Deleted files
- Untracked files

Summarize changes in plain language.
Do NOT commit or push.

---

## Step 2: Change Classification
Classify the identified changes as:
- Feature
- Bug fix
- Refactor
- Documentation
- Chore

If legacy-safe mode is enabled:
- Flag any change that looks structural or risky
- Warn if scope exceeds “local change”

---

## Step 3: Commit Preview
Generate:
- A proposed commit message
- A concise description of intent
- A list of files to be included

Explicitly ask:
“Do you want to include ALL of these changes?”

Allow the user to:
- Approve all
- Exclude specific files
- Abort

---

## Step 4: Confirmation Gate (Hard Stop)
Ask explicitly:

“Do you approve committing and pushing these changes?”

If the answer is anything other than an explicit yes:
- Abort
- Take no action

---

## Step 5: Publish (If Approved)
If and only if approved:
- Run `git add` for approved files
- Run `git commit` using the approved message
- Run `git push` to the current branch

Confirm:
- Commit hash
- Branch name
- Push success

---

## Step 6: Post-Publish Reflection
Summarize:
- What was published
- Why
- Any follow-up suggestions (optional)

---

## Output Format
1. Change Summary
2. Risk & Scope Notes
3. Commit Preview
4. Approval Prompt
5. Publish Confirmation (if executed)
