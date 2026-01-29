---
description: The "Lead Architect" phase. Precedes any coding activity. It analyzes the request, identifies risks, maps dependencies, and produces a validated Development Plan.
---

# Strategic Brainstorm Workflow

## Description
The "Lead Architect" phase. Precedes any coding activity. It analyzes the request, identifies risks, maps dependencies, and produces a validated Development Plan.

## Steps

1.  **Logic Sweep**:
    - Trigger `brainstormer.skill.md`.
    - Input: Feature Request.
    - Output: `Brainstorm Report`.

2.  **Safety Check**:
    - Trigger `dependency_mapper.skill.md`.
    - Input: `Brainstorm Report`.
    - Output: `Dependency Map` with collision warnings.

3.  **Plan Generation**:
    - Synthesize the `Brainstorm Report` and `Dependency Map`.
    - Create `.agent/memory/development_plan.md` containing:
        - **Architecture Overview**
        - **Worker Assignment** (mapped to tasks)
        - **Risk Assessment** (from Edge Cases & Collisions)
        - **Success Criteria**

4.  **Validation**:
    - Check if the plan adheres to `.agent/rules/planning_priority.rule.md`.
    - If collisions exist, re-route tasks to be serialized instead of parallel.

5.  **Handoff**:
    - Mark plan as `VALIDATED`.
    - Trigger `task_sharder.skill.md` to begin execution based on the plan.

## Triggers
- New Feature Request.
- Major Refactor.
- "Initiate Brainstorming Protocol" command.
