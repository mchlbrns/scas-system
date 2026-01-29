# Execution Patterns Log

## Overview
Records successful execution patterns, learned behaviors, and newly synthesized skills. Used for state recovery and optimization.

## Project Context (SCASI/DCMS)

> **Last Initialized**: 2026-01-29T15:37:15+08:00

### Stack Summary
| Layer | Technology | Version |
|-------|------------|---------|
| Backend | Django + DRF | 4.2.x |
| Frontend | Next.js + React | 16.1.4 / 19.2.3 |
| Database | MySQL | - |
| Backend Testing | pytest + pytest-django | - |
| Frontend Testing | vitest + testing-library | 3.2.4 |

### Common Execution Commands
```bash
# Backend Development
cd c:\Users\Geloo\Desktop\SCASI
python manage.py runserver
pytest --cov

# Frontend Development  
cd c:\Users\Geloo\Desktop\SCASI\frontend
npm run dev
npm run test
```

### Django Apps
`core`, `clients`, `analysts`, `receivables`, `payments`, `ptp`, `targets`, `dashboard`, `teams`

## Registered Skills
- `task_sharder.skill.md`: Breaks down requirements.
- `evaluator.skill.md`: Verifies code changes.
- `context_analyzer.skill.md`: Project environment analysis.
- `documentation_updater.skill.md`: README maintenance.
- `brainstormer.skill.md`: Architectural analysis.
- `dependency_mapper.skill.md`: Collision prevention.
- `status_reporter.skill.md`: Heartbeat metrics.
- `ui_harmonizer.skill.md`: Standardizes dashbaord UI components.
- `api_contract_guardian.skill.md`: Ensures DRF and React Query sync.
- `react_data_patterns.skill.md`: Standardizes React Query data hooks.
- `datatable_master.skill.md`: Standardizes DataTable layouts and interactions.
- `django_test_specialist.skill.md`: Executes and debugs Django tests.
- `vitest_runner.skill.md`: Executes and debugs Frontend (Vitest) tests.
- `git_orchestrator.skill.md`: Automates GitHub synchronization and restoration.

## Learned Patterns
| ID | Pattern Description | Success Rate | Last Used |
|----|---------------------|--------------|-----------|
| P001 | Django app structure follows standard MVT | - | 2026-01-27 |
| P002 | Frontend uses App Router with TypeScript | - | 2026-01-27 |
| P003 | API authentication via JWT (SimpleJWT) | - | 2026-01-27 |
| P004 | Enforced Design System (semantic tokens, dcms-card) | High | 2026-01-28 |
| P005 | PowerShell: Binary redirection safety (Encoding, Newlines) | High | 2026-01-28 |
