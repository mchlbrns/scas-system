---
description: # Security Audit Workflow
---

# Security Audit Workflow
Version: 1.1.0

Command: /security-audit

## Objective
Provide calm, proportional security insight without blocking
development or forcing refactors.

---

## Step 1: Scope Identification
Inspect:
- Changed files
- Entry points
- External interfaces

---

## Step 2: Risk Analysis
Identify:
- Input validation risks
- Auth/authz concerns
- Secret exposure
- Dependency risks

---

## Step 3: Policy Alignment
Cross-check against active security rules.

---

## Step 4: Summary & Guidance
Classify findings:
- Informational
- Low
- Medium
- High

Provide clear mitigation suggestions.

---

## Step 5: Remediation (Optional)
If mitigation approved:
- Apply fixes to code or configuration
- Verify with system checks

---

## Output Format
1. Findings Table
2. Severity Assessment
3. Recommendations
4. Remediation Summary (if applicable)
