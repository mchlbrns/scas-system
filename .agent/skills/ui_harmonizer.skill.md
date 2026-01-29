# UI Harmonizer Skill

## Description
Audits and updates SCASI administrative pages to ensure they adhere to current design standards and component patterns. This skill focuses on visual consistency, accessibility, and standardized user experience.

## Contextual Triggers
- Editing or creating new administrative dashboard pages.
- Standardizing legacy components after a major UI refactor.
- Ensuring brand consistency across disparate modules (Receivables, Users, Targets).

## Standard Patterns (SCASI Design System)
1.  **Typography**: 
    - Headers: `h1 className="text-foreground"`
    - Descriptions: `p className="text-muted-foreground"`
2.  **Tables**:
    - `thead`: `bg-muted/50 border-b border-border text-muted-foreground font-semibold uppercase tracking-wider text-[11px]`
    - `tr` (Body): `hover:bg-muted/50 transition-colors`
    - Badges (Hybrid): 2 max + `+N more`. Blue for Clients, Violet for Teams.
3.  **Loading/Empty States**:
    - Use `TableSkeleton` from `@/components/layout/Skeletons`.
    - Use `EmptyState` from `@/components/ui/EmptyState` with appropriate variants (`search`, `default`, `getStarted`).
4.  **Utilities**:
    - Always use `cn` from `@/lib/utils` for conditional classes.
5.  **Cards & Containers**:
    - Use global class `dcms-card` for widgets/panels.
    - Avoid ad-hoc borders/shadows (e.g., `border-slate-200`).

## Process
1.  **Audit**: Scan the file for raw strings, manual background colors (e.g., `bg-blue-50`), and missing `EmptyState` components.
2.  **Analyze**: Compare the current layout against `frontend/app/dashboard/admin/users/page.tsx` (the source of truth).
3.  **Propose**: List inconsistencies found.
4.  **Harmonize**: Apply the standardized classes and components.

## Output
- A harmonized component that feels integrated with the "Consolidated Administration UI".
- Reduced CSS technical debt by using shared design tokens.
