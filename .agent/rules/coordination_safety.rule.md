# Coordination Safety Rules

## Purpose
To prevent race conditions, merge conflicts, and data corruption during parallel execution of tasks by multiple agents or threads.

## Rules

1. **Atomic File Operations**: 
   - Ensure that write operations to shared files are atomic or properly locked.
   - Avoid simultaneous edits to the same file by different workers.

2. **Branching Strategy**:
   - Each parallel task must operate on its own feature branch or isolated workspace.
   - Merges to the main branch must be serialized and validated.

3. **State Verification**:
   - Before applying changes, verify that the current state matches the expected base state.
   - If the state has changed (e.g., file modified by another process), re-sync before proceeding.

4. **Conflict Resolution**:
   - If a merge conflict is detected, abort the automatic merge.
   - Trigger a manual review or a dedicated conflict resolution workflow.

5. **Resource Locking**:
   - Acquire locks on shared resources (e.g., databases, configuration files) before modification.
   - Release locks immediately after the operation is complete.
