---
description: A persistent background loop that ensures system integrity, monitors parallel workers, and maintains high-fidelity logs. Executes on a fixed interval (e.g., every 300s) or after major milestones.
---

# System Heartbeat Workflow

## Description
A persistent background loop that ensures system integrity, monitors parallel workers, and maintains high-fidelity logs. Executes on a fixed interval (e.g., every 300s) or after major milestones.

## Steps

1. **Pulse Check**:
   - Trigger `skills/status_reporter.skill.md`.
   - Retrieve the `System Pulse Report`.

2. **Analysis**:
   - Check against `rules/heartbeat_integrity.rule.md`:
     - Are any workers stalled?
     - Is context pressure critical?
     - Is the directory integrity compromised?

3. **Intervention (If needed)**:
   - **Stalled Worker**: Command the CLI to kill the process and re-queue the task shard.
   - **Critical Failure**: Trigger `workflows/self_fix.workflow.md` immediately.

4. **State Commit**:
   - Append the `System Pulse Report` to `.agent/memory/performance_metrics.log.md`.
   - Update `memory/execution_patterns.log.md` if a new stability pattern is observed.

5. **Cycle**:
   - Sleep for [N] seconds.
   - Repeat from Step 1.

## Triggers
- Timer (e.g., every 5 mins).
- Completion of a major Task Shard.
- Manual "Ping" command.
