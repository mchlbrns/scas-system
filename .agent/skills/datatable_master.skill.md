---
name: datatable_master
description: Standardizes the implementation of the `DataTable` component to ensure consistent layout behavior (fixed height vs scrollable), sort visibility, and responsive design across the application.
---

# DataTable Master Skill

## Description
This skill outlines the strict standards for implementing the `DataTable` component and its containing pages. It solves common issues like full-page scrolling, hidden sort indicators, and transparent sticky headers.

## Trigger Conditions
- Creating or refactoring a page with a `DataTable`.
- User requests to "fix scrolling" or "fix headers" in a list view.
- Adding sort functionality to columns.

## Standards

### 1. Application Layout (Fixed Height)
To prevent the entire page from scrolling (keeping the sidebar/header static), use an "Application Layout" approach.

**Parent Container (`page.tsx`)**:
Must use `h-[calc(100vh-OFFSET)]` where OFFSET is usually the header height + padding (e.g., `4rem` or `64px`).
```tsx
// page.tsx
return (
    <div className="h-[calc(100vh-4rem)] p-6 flex flex-col gap-6">
        <Header />
        {/* Table container takes remaining space */}
        <div className="flex-1 min-h-0">
             <DataTable data={data} columns={columns} scrollable={true} />
        </div>
    </div>
);
```

### 2. DataTable Component Props
Always use `scrollable={true}` when inside a fixed-height layout.

### 3. Header Styles
Sticky headers MUST be opaque to prevent content bleed-through.
**Incorrect**: `bg-muted/50` (Transparent)
**Correct**: `bg-card` (Opaque)

```tsx
<thead className="bg-card border-b border-border sticky top-0 z-10">
```

### 4. Sort Indicators
Sort icons must be accessible but not visual clutter. Use the `group` pattern on the `th` element.

**Pattern**:
1. Add `group` to the `th` class.
2. Icon should be `opacity-30` by default (visible but faint).
3. Icon should be `group-hover:opacity-100` (bright on interaction).

```tsx
<th className="... group">
    {/* ... Label */}
    <ChevronsUpDown className="opacity-30 group-hover:opacity-100 transition-opacity" />
</th>
```

## Output
- A `page.tsx` that fits exactly within the viewport.
- A `DataTable` that scrolls internally.
- Clean, opaque headers with intuitive sort interactions.
