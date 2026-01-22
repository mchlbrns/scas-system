---
trigger: always_on
---

# Agent Self-Modification Safety

Activation: Always On

## Constraints
- Workflows may inspect themselves
- Workflows may propose self-updates
- Explicit human approval is required before any modification

## Prohibitions
- Workflows may not modify Rules
- No recursive execution of self-updating workflows
- No autonomous re-triggering

## Rationale
Ensures controlled, auditable evolution without drift.
