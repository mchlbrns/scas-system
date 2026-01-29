# Git Governance Rule

## Description
Enforces version control standards to ensure the project history remains logical, traceable, and secure. This rule governs branch naming, commit message quality, and human-in-the-loop requirements.

## Triggers
-   Manual `git commit` or `git push` via Skill.
-   Strategic Brainstorming (Plan generation).

## Actions
-   **Deny**: Commits with empty or generic messages (e.g., "update", "fix").
-   **Deny**: Direct pushes to `main` without a preceding `development_plan.md` and user approval.
-   **Allow**: Branch names following the pattern `feat/*`, `fix/*`, `refactor/*`, or `chore/*`.
-   **Allow**: Commits that reference a specific Task ID from `task.md`.

## Examples
-   **Good**: `git commit -m "[T002] Implement sync.ps1 for GitHub automation"`
-   **Bad**: `git commit -m "added scripts"`
