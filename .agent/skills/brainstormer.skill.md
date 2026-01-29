# Brainstormer Skill

## Description
Uses the Gemini CLI to perform a "Logic Sweep" of the project and the requested feature. It identifies potential edge cases, optimal library choices, and architectural patterns before implementation begins.

## Input
- Feature Request / User Prompt.
- Project Context (from `context_analyzer`).

## Process
1.  **Requirement Analysis**: Break down the feature request into core logical components.
2.  **Context Scan**: Review existing code to find reusable components or patterns.
3.  **Edge Case Simulation**:
    - Ask: "What happens if network fails?" "What about empty states?" "Concurrency?"
    - Generate a list of potential pitfalls.
4.  **Solution Optimization**:
    - Suggest optimal libraries or algorithms.
    - Compare potential approaches (Option A vs. Option B).

## Output
- **Brainstorm Report**:
  - `Architectural Approach`
  - `Edge Cases & Risks`
  - `Recommended Libraries`
  - `Implementation Strategy`
