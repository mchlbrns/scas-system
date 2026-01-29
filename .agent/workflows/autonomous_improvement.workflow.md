---
description: This workflow enables the "Skill-Synthesis Protocol" (Autogeny). It detects capability gaps and synthesizes new skills to fill them.
---

# Autonomous Improvement Workflow

## Description
This workflow enables the "Skill-Synthesis Protocol" (Autogeny). It detects capability gaps and synthesizes new skills to fill them.

## Steps

1. **Gap Analysis & Classification**:
   - Triggered when a task requirement does not match any existing skill, rule, or workflow.
   - Define the missing Logic/Capability.
   - **Classify** the gap:
     - `Capability` -> **Skill** (Tools, Actions)
     - `Constraint/Pattern` -> **Rule** (Safety, Stylistic, Prohibitions)
     - `Process/Sequence` -> **Workflow** (Orchestration, multi-step sequences)

2. **Research (Gemini CLI)**:
   - Use Gemini CLI to search for external documentation, library specs, or best practices.
   - Command: `gemini-cli research "<missing_item_description>"`
   - Note: Search for *patterns* or *guidelines* if synthesizing a Rule or Workflow.

3. **Synthesis**:
   - **If Skill**:
     - Draft `[skill_name].skill.md`.
     - Sections: Description, Input, Process, Output.
   - **If Rule**:
     - Draft `[rule_name].rule.md`.
     - Sections: Description, Triggers, Actions (Allow/Deny), Examples.
   - **If Workflow**:
     - Draft `[workflow_name].workflow.md`.
     - Sections: Description, Steps (with annotations like `// turbo`), Triggers.

4. **Verification**:
   - Invoke `evaluator.skill.md` with context.
   - **Skill**: Run a "Mock Execution" (dry run).
   - **Rule**: Check for conflicts with existing rules (Logical Contradiction Check).
   - **Workflow**: Validation of step sequence and dependency availability.

5. **Registration**:
   - If Verification PASS:
     - **Skill**: Save to `.agent/skills/[name].skill.md`.
     - **Rule**: Save to `.agent/rules/[name].rule.md`.
     - **Workflow**: Save to `.agent/workflows/[name].workflow.md`.
     - Update `.agent/memory/execution_patterns.log.md` with the new addition.
   - If Verification FAIL:
     - Iterate on Step 3 (Synthesis) with feedback.

6. **Documentation Update**:
    - Trigger `documentation_updater.skill.md`.
    - Regenerate `README.md` to include the newly synthesized skill.

## Triggers
- Task requirement mismatch (Missing Skill).
- Anti-pattern detection (Missing Rule).
- Repetitive manual sequence detected (Missing Workflow).
- Explicit "Synthesis" command.
