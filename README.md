# SCASI (System for Collection Analysis and Strategy Implementation)

> **Status**: Active Development
> **Stack**: Django 4.2+, Next.js 16, TypeScript, MySQL

**SCASI**, also known as **DCMS** (Daily Collection Monitoring System), is a full-stack platform designed for financial teams to monitor, analyze, and strategize daily collections. It aggregates data from various sources to provide real-time metrics, audit logs, and collection targets.

## Key Technologies
- **Backend**: Django, DRF, MySQL, JWT Authentication
- **Frontend**: Next.js (App Router), React 19, TypeScript, Tailwind CSS 4, Zustand, TanStack Query

---

## Quick Start

### Prerequisites
-   Node.js 18+
-   Python 3.10+
-   MySQL Database

### Running the Application
To run the full stack, you need two terminal sessions.

**1. Backend (Django)**
```bash
# In the root directory
python manage.py runserver
```
API runs at `http://localhost:8000`.

**2. Frontend (Next.js)**
```bash
cd frontend

# Install dependencies (first time only)
npm install

# Start development server
npm run dev
```
Frontend runs at `http://localhost:3000` and proxies API requests to the backend.

---

## Anti-Gravity IDE "Nexus" System

> **Version**: 2.6 (Lead Architect Edition)
> **Architecture**: Decentralized Agentic Filesystem

### Overview
This repository is architected and managed by the **Nexus** autonomous agent. The operational logic is fully decentralized across the `.agent/` directory, allowing for recursive self-optimization and "Anti-Gravity" development speed.

### How It Works
The Nexus system operates by orchestrating a set of definitions stored in the local filesystem. It indexes these files to determine its capabilities and executes complex tasks through defined workflows.

### Directory Structure
- **`.agent/rules/`**: Governance protocols that ensure safety and consistency.
- **`.agent/skills/`**: Atomic capabilities (tools) the agent can perform.
- **`.agent/workflows/`**: Sequenced patterns of execution.
- **`.agent/memory/`**: Logs for state recovery and learning.

### SCASI Application Setup
SCASI is the target application managed by this system.


## Capabilities (Skills)
The agent currently possesses the following skills:

| Skill | Description | Input |
|-------|-------------|-------|
| **Task Sharder** (`task_sharder.skill.md`) | Breaks down complex requirements into independent, parallelizable shards. | Requirements, File List |
| **Evaluator** (`evaluator.skill.md`) | Verifies code changes against quality, correctness, and safety standards. | Diffs, Logs, Metrics |
| **Context Analyzer** (`context_analyzer.skill.md`) | Scans the project directory to identify technical stacks, frameworks, and patterns. | Project Path |
| **Status Reporter** (`status_reporter.skill.md`) | Aggregates system metrics and worker statuses for the Heartbeat protocol. | Process List, Logs |
| **Brainstormer** (`brainstormer.skill.md`) | Performs logic sweeps to identify edge cases and optimal architectural approaches. | Feature Request |
| **Dependency Mapper** (`dependency_mapper.skill.md`) | Visualizes file modifications to prevent context collisions between workers. | Proposed Plan |
| **Documentation Updater** (`documentation_updater.skill.md`) | Automatically updates this `README.md` to reflect new skills and system changes. | .agent/ directory |
| **UI Harmonizer** (`ui_harmonizer.skill.md`) | Audits and standardizes SCASI administrative pages to ensure they adhere to design tokens and layout patterns. | Dashboard Page Files |
| **API Contract Guardian** (`api_contract_guardian.skill.md`) | Synchronizes and audits the data contract between DRF serializers/viewsets and React hooks to prevent breakage. | Serializers, Hooks |
| **React Data Patterns** (`react_data_patterns.skill.md`) | Standardizes the implementation of data fetching, state management, and Demo Mode. | Hooks, Store |
| **Django Test Specialist** (`django_test_specialist.skill.md`) | Executes and debugs Django tests, handling environment and configuration context. | Test Targets |
| **Vitest Runner** (`vitest_runner.skill.md`) | Specializes in executing/debugging frontend tests using Vitest. | Test Targets, Context |
| **Datatable Master** (`datatable_master.skill.md`) | Standardizes DataTable layouts, sorting, and user interactions across administrative pages. | Component Files |
| **Git Orchestrator** (`git_orchestrator.skill.md`) | Automates GitHub synchronization and restoration using project-specific scripts. | Action, Message |

## Workflows
The agent executes tasks using these workflows:

### 1. Initiate (`initiate.workflow.md`)
**The Entry Point.**
Automatically analyzes the project environment upon startup or request. It uses the `Context Analyzer` to detect languages and frameworks, then dynamically adapts the agent's skills and rules to match the project's specific requirements.

### 2. Strategic Brainstorm (`strategic_brainstorm.workflow.md`)
**The Architect Phase.**
Before any code is written, this workflow analyzes the request, maps dependencies, and generates a validated `development_plan.md` to ensure architectural integrity and prevent conflicts.

### 3. System Heartbeat (`system_heartbeat.workflow.md`)
**Background Monitor.**
A persistent loop that checks system health, monitors parallel workers for stalls, and enforces integrity rules. It triggers `self_fix` if critical failures are detected.

### 4. Parallel Execution (`parallel_execute.workflow.md`)
Orchestrates the concurrent execution of multiple task shards using available workers (e.g., Gemini CLI) to maximize throughput.

### 5. Self-Fix (`self_fix.workflow.md`)
A recovery mechanism that attempts to automatically resolve errors encountered during execution. It analyzes failures, hypothesizes fixes, and verifies them using the Evaluator.

### 6. Autonomous Improvement (`autonomous_improvement.workflow.md`)
**The Evolutionary Engine.**
- **Gap Analysis**: Detects when a required capability is missing.
- **Research**: Uses Gemini CLI to research the missing skill.
- **Synthesis**: Drafts and verifies a new `[skill].skill.md`.
- **Registration**: Adds the skill to the library and triggers the **Documentation Updater**.

## Usage
To interact with the Nexus system:

1.  **Initialization**: Run the `Initiate` workflow to calibrate the agent to your specific project.
2.  **Planning**: Use the `Strategic Brainstorm` workflow to generate a robust development plan for new features.
3.  **Task Assignment**: Provide a high-level goal. The agent uses the `Task Sharder` to break it down based on the plan.
4.  **Background**: The `System Heartbeat` will automatically run to ensure stability.
5.  **Evolution**: If the agent encounters a problem it can't solve, it triggers the `Autonomous Improvement` workflow to build the tool it needs.

---
*This document is automatically maintained by the `documentation_updater` skill. Last updated by Nexus on 2026-01-29 10:54.*
