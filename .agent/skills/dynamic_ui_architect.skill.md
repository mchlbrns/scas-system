# Dynamic UI Architect Skill

## Description
Standardizes the creation of metadata-driven user interfaces, where the layout or fields are user-configurable. This skill covers the implementation of **Renderers** (displaying content based on schema) and **Editors** (visual tools to modify that schema), ensuring separation of concerns and a high-quality user experience.

## Contextual Triggers
- Building configurable dashboards or reports.
- Implementing "Form Builders" or "Layout Editors".
- Creating components that render based on dynamic JSON payloads.
- Implementing "Legacy" or "High-Density" views that require specific rendering modes.

## Standard Patterns

### 1. Schema Definitions (`types/schema.ts`)
Always define strict TypeScript interfaces for the configuration object.
```typescript
export interface LayoutConfig {
    sections: LayoutSection[];
    version: number;
}

export interface LayoutSection {
    id: string;
    title: string;
    type: 'grid' | 'list' | 'table';
    fields: LayoutField[]; // Nested arrays
}
```

### 2. The Renderer Pattern
- **Pure Component**: Should not manage state. Receives `config` and `data`.
- **Fallbacks**: Always handle missing/null config gracefully with a helpful empty state.
- **Micro-Components**: Break down complex renderers (e.g., `FieldRenderer`, `SectionRenderer`).
- **Density Control**: Support "Compact" vs "Comfortable" modes if replacing legacy systems.

### 3. The Editor Pattern
- **Local State**: Use `useState` for the working copy of the schema. Only commit to parent/backend on "Save".
- **UX Essentials**:
    - **Live Preview**: Toggle to see the result immediately.
    - **Quick Add Presets**: Buttons to add common configurations (e.g., "Contact Info Section") to reduce friction.
    - **Collapsible Sections**: Use Accordions for managing long lists of sections/fields.
    - **Visual Hierarchy**: Distinct headers, icons, and badges.
- **Interactivity**:
    - Reordering (Up/Down buttons).
    - Duplication (Copy button).
    - Inline editing (Edit-in-place for labels).

### 4. High-Density Layouts (Legacy Emulation)
When emulating legacy systems:
- **Structure**: Use CSS Grid (`grid-cols-12`) for rigid alignment.
- **Visuals**: bordered rows, distinct background colors for Labels vs Values.
- **Typography**: `text-xs`, `uppercase` labels, `font-bold` values.
- **Headers**: distinct colored bars (e.g., Blue background, White text).

## Process
1.  **Define Schema**: Create the TypeScript interface for the JSON config.
2.  **Build Renderer**: Create the component that displays the data using the schema. Ensure it handles edge cases.
3.  **Build Editor**:
    - Scaffolding: creating the container and state.
    - Sections: Implement Add/Remove/Collapse logic.
    - Fields: Implement Add/Edit/Remove logic within sections.
    - Polish: Add "Preview", "Presets", and Icons.
4.  **Verify**: Test the full loop (Edit -> Save -> Render).

## Output
- A pair of components: `[Feature]Renderer.tsx` and `[Feature]Editor.tsx`.
- A resilient JSON schema definition.
