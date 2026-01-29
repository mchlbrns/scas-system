---
description: Enforces the use of the SCASI Design System (semantic tokens, shared utility classes) for all UI components to ensure visual consistency.
---

# Design System Enforcement Rule

## Triggers
- Creating new `.tsx` UI components.
- Refactoring existing UI components.
- Styling changes involving colors or layout containers.

## Rules
1.  **Semantic Colors Over Raw Values**:
    - **DENY**: Using raw Tailwind colors like `bg-blue-500`, `text-yellow-900`, `border-gray-200` for structural elements.
    - **ALLOW**: Using semantic tokens: `bg-primary`, `text-muted-foreground`, `border-border`, `bg-card`.
    - *Exception*: Data visualization (e.g., charts, specific badges) where distinct hues are required.

2.  **Standardized Containers**:
    - **MUST** use the `dcms-card` class for dashboard widgets and containers instead of manually applying `bg-white rounded border shadow`.
    - **MUST** use the `dcms-button` or project-specific button variants if available.

3.  **Utility Usage**:
    - **MUST** use the `cn()` utility from `@/lib/utils` for conditional class application.

## Examples

### ❌ Incorrect
```tsx
<div className="bg-white border-gray-200 shadow rounded-lg p-4">
  <h3 className="text-gray-900 font-bold">Title</h3>
</div>
```

### ✅ Correct
```tsx
<div className="dcms-card p-4">
  <h3 className="text-foreground font-bold">Title</h3>
</div>
```
