# Git Orchestrator Skill

## Description
Automates the synchronization of the SCASI codebase with GitHub. This skill manages the interaction between the local development environment and the remote repository by orchestrating existing automation scripts (`sync.ps1`, `restore.ps1`) and ensuring version control best practices.

## Input
-   `Action`: `sync`, `restore`, `status`.
-   `Message`: Commit message (optional, can be auto-generated from walkthrough).
-   `Target`: Branch name (optional, defaults to current).
-   `Scope`: `code`, `db`, or `both` (relevant for restore).

## Process
1.  **Branch Check**: Identify the current active branch using `git branch --show-current`.
2.  **Safety Sweep**: Run `git status` to verify there are no unmanaged collisions.
3.  **Synchronization**:
    -   If `sync`: Execute `scripts/sync.ps1`. If no message is provided, analyze `brain/walkthrough.md` to generate a summary.
    -   If `restore`: Execute `scripts/restore.ps1` with appropriate flags based on `Scope`.
4.  **Verification**: Confirm the operation succeeded by checking git logs or status output.

## Output
-   `Result`: Success/Failure.
-   `Summary`: Description of the changes pushed or states restored.
-   `Next Steps`: Recommendations for Pull Requests or merges.
