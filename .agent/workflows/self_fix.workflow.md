---
description: A recovery mechanism that attempts to automatically resolve errors encountered during task execution or verification.
---

# Self-Fix Workflow

## Description
A recovery mechanism that attempts to automatically resolve errors encountered during task execution or verification.

## Steps

1. **Error Detection**: Triggered by a failure in `parallel_execute` or a rejection by `evaluator.skill.md`.
2. **Analysis**:
   - Read the error log/feedback.
   - Identify the specific file or code segment causing the issue.
3. **Hypothesis Generation**: Formulate a potential fix (code change).
4. **Application**: Apply the fix to the codebase.
5. **Verification**:
   - Invoke `evaluator.skill.md` to verify the fix.
   - If PASS: Commit/Merge and resume original workflow.
   - If FAIL: Retry steps 2-5 (up to max_retries).
6. **Escalation**: If max_retries reached, log detailed failure report in `.agent/memory/performance_metrics.log.md` and halt.

## Triggers
- Test failure.
- Build error.
- Linter violation.
- Evaluator rejection.
