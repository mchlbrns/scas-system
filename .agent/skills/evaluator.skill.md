# Evaluator Skill

## Description
This skill verifies code changes, ensuring they meet correctness, quality, and performance standards. It is used to validate fixes and features before commitment.

## Input
- Code changes (diffs or modified files).
- Test results (logs, exit codes).
- Linter/Formatter output.
- Performance metrics.

## Process
1. **Syntax & Static Analysis**: Check for syntax errors and linting issues.
2. **Functional Verification**: Run relevant tests (unit, integration) and check for pass/fail status.
3. **Logic Inspection**: Review code for potential logical errors, edge cases, or security vulnerabilities.
4. **Performance Check**: Compare performance metrics against baselines (if applicable).
5. **Rule Compliance**: Ensure changes adhere to `.agent/rules/coordination_safety.rule.md` and other governance rules.

## Output
- **Verdict**: PASS / FAIL
- **Feedback**: Detailed explanation of issues found or confirmation of success.
- **Recommendations**: specific steps to fix identified problems.
