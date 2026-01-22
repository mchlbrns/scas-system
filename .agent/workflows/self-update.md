---
description: # Self-Updating Workflow
---

# Self-Updating Workflow
Version: 1.0.0

Command: /self-update

## Objective
Improve workflows over time based on usage and feedback.

---

## Step 1: Introspection
Load @.agent/workflows/ and identify friction.

---

## Step 2: Evaluation
Assess gaps, repetition, and rule alignment.

---

## Step 3: Proposal
Generate a minimal diff. No rule changes.

---

## Step 4: Approval Gate
Ask for explicit approval.

Abort if not approved.

---

## Step 5: Apply Update
If approved:
- Update workflow
- Increment version
- Summarize changes

---

## Output Format
1. Evaluation Summary
2. Proposed Diff
3. Approval Prompt
4. Confirmation
