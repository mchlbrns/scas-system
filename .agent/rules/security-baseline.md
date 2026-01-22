---
trigger: model_decision
description: # Security Baseline
---

# Security Baseline

Activation: Model Decision

## Constraints
- Never introduce secrets into code or logs
- Validate external inputs where reasonable
- Prefer least-privilege and secure defaults
- Flag uncertainty instead of guessing

## Prohibitions
- No hardcoded credentials
- No bypassing authentication or authorization
- No insecure defaults without warning

## Rationale
Security should be visible, calm, and proportional—not paranoid.