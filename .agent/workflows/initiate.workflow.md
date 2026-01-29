---
description: The primary entry point for the Nexus agent. This workflow automatically analyzes the target project environment and dynamically adapts the agent's internal state (skills, rules, workflows, memory) to match the project's requirements.
---

# Initiate Workflow

## Description
The primary entry point for the Nexus agent. This workflow automatically analyzes the target project environment and dynamically adapts the agent's internal state (skills, rules, workflows, memory) to match the project's requirements.

## Steps

1. **Context Analysis**:
   - Trigger `context_analyzer.skill.md`.
   - Scan the project root to identify languages, frameworks, build tools, and directory structure.
   - Output: `Project Context Report`.

2. **Calibration**:
   - Compare `Project Context Report` against current `.agent/` capabilities.
   - **Rules**: If specific framework conventions are detected (e.g., Django, React), append relevant guidelines to `.agent/rules/`.
   - **Skills**: Identify if existing skills need tuning or if new skills are required (e.g., "Need `pytest` runner" vs "Need `jest` runner").

3. **Adaptation**:
   - If gaps are found, trigger `autonomous_improvement.workflow.md` to synthesize necessary skills.
   - If configuration changes are needed, update relevant `.agent/` files directly.

4. **Memory Initialization**:
   - Update `.agent/memory/execution_patterns.log.md` with the specific project context to guide future decisions.

5. **Finalization**:
   - Trigger `documentation_updater.skill.md` to ensure `README.md` reflects the project-specific configuration.
   - Log initialization success in `.agent/memory/performance_metrics.log.md`.

## Triggers
- Agent startup.
- First run on a new project.
- Manual "Re-index" command.
