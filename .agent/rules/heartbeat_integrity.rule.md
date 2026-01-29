# Heartbeat Integrity Rules

## Purpose
To ensure continuous system reliability and prevent resource leaks or stalled processes during long-running operations.

## Rules

1. **Stalled Worker Protocol**:
   - If a worker thread shows no activity (log output or status update) for > 60 seconds (configurable), it is classified as "Stalled".
   - **Action**: Terminate the stalled process and respawn a new worker with the same context.
   - **Log**: Record the incident in `memory/performance_metrics.log.md` as "Worker Reset".

2. **Integrity Enforcement**:
   - The `.agent/` directory structure must be immutable during runtime except by authorized `self_fix` or `autonomous_improvement` workflows.
   - Any unauthorized modification detected during a heartbeat scan must trigger a "System Rollback" to the last known good state.

3. **Critical Failure Threshold**:
   - If > 30% of workers fail simultaneously or the same error occurs > 3 times in a row:
     - **Action**: Trigger `workflows/self_fix.workflow.md` immediately with "High Priority".
     - **Halt**: Pause new task dispatch until the fix is verified.
