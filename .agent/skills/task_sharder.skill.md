# Task Sharder Skill

## Description
This skill breaks down complex development requirements into smaller, manageable, and independent sub-tasks that can be executed in parallel.

## Input
- High-level project requirements or feature descriptions.
- Current codebase structure (file list).

## Process
1. **Analyze Requirements**: Identify the core components of the request.
2. **Identify Dependencies**: Determine which parts depend on others.
3. **Decompose**: Split the work into atomic units (shards).
   - Each shard should ideally affect a specific set of files or functions.
   - Ideally, shards should be testable independently.
4. **Assign Priority**: Order shards based on dependencies and critical path.

## Output
- A list of tasks (shards), each with:
  - Title
  - Description
  - Target files
  - Dependencies
  - Acceptance criteria
