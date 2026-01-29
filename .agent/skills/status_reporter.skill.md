# Status Reporter Skill

## Description
Aggregates real-time system metrics, worker statuses, and health indicators into a concise "System Pulse" report. Used by the Heartbeat protocol.

## Input
- Active process list (PIDs).
- Worker logs/output streams.
- `.agent/` directory checksums (for integrity).

## Process
1. **Worker Scan**:
   - Query the OS or CLI process manager for active worker threads.
   - Check last modified timestamps of worker logs to determine activity.
2. **Resource Metrics**:
   - Measure CPU/Memory usage (simulated or actual via `top`/`ps`).
   - Estimate Context Window pressure based on file sizes being processed.
3. **Integrity Check**:
   - Verify existence and read-access of critical files (`rules/*.md`, `skills/*.md`).
   - Compare current state against `memory/execution_patterns.log.md` (optional).

## Output
- **System Pulse Report**:
  ```json
  {
    "timestamp": "ISO-8601",
    "active_workers": N,
    "stalled_workers": N,
    "context_pressure": "Low/Med/High",
    "integrity_status": "OK/CORRUPTED",
    "last_self_heal": "Timestamp"
  }
  ```
