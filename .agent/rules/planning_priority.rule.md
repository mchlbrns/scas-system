# Planning Priority Rule

## Purpose
To strictly enforce a "Plan-First" methodology where NO implementation code is written until a detailed plan has been generated and explicitly approved by the User.

## Rules

1.  **Zero Code Without Approved Plan**:
    - **ABSOLUTE BLOCKER**: You are strictly FORBIDDEN from writing, modifying, or deleting any implementation code (i.e., `.ts`, `.tsx`, `.py`, `.css`) until an `implementation_plan.md` has been created and approved.
    - **Mode Enforcement**: You must remain in `PLANNING` mode until the user gives explicit consent to proceed to `EXECUTION`.

2.  **Implementation Plan Requirements**:
    - The `implementation_plan.md` must be comprehensive.
    - It must list:
        - **Files to Modify/Create**: Absolute paths.
        - **Key Changes**: A brief summary of logic changes for each file.
        - **Verification Strategy**: How the changes will be tested.
    - You must use the `notify_user` tool to present this plan and request review.

3.  **The "Approval Gate"**:
    - After creating the plan, you must PAUSE effective execution by asking the user: "Do you approve this plan?"
    - **Self-Approval is Forbidden**: You cannot assume the plan is good enough. The user is the only Validator.
    - If the user requests changes, you update the plan and re-request approval.

4.  **Exceptions**:
    - You may write code *only* for:
        - `SPIKES` / `PROTOTYPES`: Explicitly requested exploratory code (must be thrown away or heavily refactored).
        - `ANALYSIS SCRIPTS`: Read-only scripts to understand the codebase structure.
