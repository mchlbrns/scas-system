# Project Context Report
**Generated:** 2026-02-02T08:57:05+08:00
**Status:** Calibrated

## Technical Stack
- **Backend:** Python, Django 4.2+, Django REST Framework
  - Testing: pytest, factory-boy
  - Auth: SimpleJWT
  - Database: MySQL (mysqlclient)
- **Frontend:** TypeScript, Next.js 16 (React 19), Tailwind CSS 4
  - Testing: Vitest, React Testing Library
  - State Management: Zustand
  - Data Fetching: TanStack Query
- **Database:** MySQL

## Detected Conventions
- **Django**: Top-level app structure (`core`, `analysts`, `clients`, etc.).
- **Next.js**: App Router structure (`frontend/app`).
- **Styling**: Tailwind CSS classes.
- **Linting**: ESLint (frontend).

## Agent Calibration
- **Skills**: Verified match (Django, React, Vitest skills present).
- **Rules**: Verified match (Auth, Testing, UI rules present).
