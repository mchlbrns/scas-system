---
description: Orchestrates the concurrent execution of multiple development tasks (shards) using available worker resources (e.g., Gemini CLI).
---

# Parallel Execute Workflow

## Description
Orchestrates the concurrent execution of multiple development tasks (shards) using available worker resources (e.g., Gemini CLI).

## Steps

// turbo-all
1. **Input Task List**: Receive the list of shards from the `task_sharder` skill.
2. **Resource Allocation**: Check available worker slots/threads.
3. **Dispatch**:
   - For each independent task, spawn a worker process.
   - Command: `& "C:\Program Files\nodejs\gemini.cmd" "Task: <task_id>. Context: <context_files>"`
4. **Monitor**:
   - Track the status of each worker.
   - Collect logs and outputs.
5. **Aggregation**:
   - Wait for all dispatched workers to complete.
   - Collect results (diffs, artifacts).
6. **Safety Check**:
   - Validate outputs against `.agent/rules/coordination_safety.rule.md`.
   - Ensure no conflicting changes.
7. **Merge**: Apply changes to the shared workspace/branch.

## Triggers
- `task_sharder` completion.
- Manual invocation for batch processing.
