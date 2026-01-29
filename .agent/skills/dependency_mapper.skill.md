# Dependency Mapper Skill

## Description
Visualizes and tracks which files will be modified by proposed tasks to prevent "Context Collision" and race conditions between parallel workers.

## Input
- `Brainstorm Report` (Proposed implementation strategy).
- Current File List.

## Process
1.  **Impact Analysis**:
    - For each proposed task/module, predict the list of files that will be created or modified.
2.  **Collision Detection**:
    - Identify if two different tasks aim to modify the same file.
    - Flag these overlaps as "Context Collisions".
3.  **Dependency Graphing**:
    - Map out dependencies between tasks (e.g., Task B needs Task A's output).
    - Identify circular dependencies.

## Output
- **Dependency Map**:
  - `Task ID` -> `Target Files`
  - `Collision Warnings` (List of overlapping files)
  - `Execution Order` (Serialized vs. Parallel safe groups)
