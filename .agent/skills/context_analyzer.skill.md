# Context Analyzer Skill

## Description
Scans the project directory to identify technical stacks, frameworks, languages, and architectural patterns. This provides the intelligence needed for the agent to self-calibrate.

## Input
- Project root directory path.
- File system access.

## Process
1. **File Inventory**: List all files and directories (ignoring `.git`, `node_modules`, etc.).
2. **Signature Detection**:
   - **Languages**: Detect based on file extensions (`.py`, `.ts`, `.rs`, etc.).
   - **Frameworks**: Look for configuration files (`package.json`, `requirements.txt`, `pom.xml`, `django.config`, `next.config.js`).
   - **Infrastructure**: Check for `Dockerfile`, `k8s` manifests, `terraform` files.
3. **Convention Mapping**:
   - Determine testing frameworks (e.g., `pytest` vs `unittest`, `jest` vs `mocha`).
   - Identify linting/formatting rules (`.eslintrc`, `pyproject.toml`).

## Output
- **Project Context Report**: A structured JSON or Markdown summary containing:
  - `Primary Language`
  - `Frameworks`
  - `Build System`
  - `Testing Strategy`
  - `Detected Conventions`
