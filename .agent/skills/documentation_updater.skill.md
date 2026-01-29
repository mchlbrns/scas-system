# Documentation Updater Skill

## Description
This skill ensures the project's root `README.md` remains synchronized with the agent's evolving capabilities. It scans the `.agent/` directory and updates the documentation to reflect current skills, workflows, and rules.

## Input
- `.agent/skills/*.md`
- `.agent/workflows/*.md`
- `.agent/rules/*.md`
- Current `README.md` (if exists)

## Process
1. **Scan**: Iterate through the `.agent` directory to identify all registered skills and workflows.
2. **Extract Metadata**: For each file, extract the `## Description`, `## Usage`, or `## Triggers` sections.
3. **Draft Content**:
   - **System Status**: List active rules and governance protocols.
   - **Capabilities (Skills)**: Create a table of available skills and their functions.
   - **Workflows**: Describe operational workflows and how to trigger them.
4. **Update**:
   - Locate the "Nexus Agent System" section in `README.md`.
   - Overwrite it with the drafted content, preserving other sections of the README.
   - If `README.md` does not exist, create it.

## Output
- Updated `README.md` with accurate, up-to-date usage instructions.
