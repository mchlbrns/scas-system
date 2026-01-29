# API Contract Guardian Skill

## Description
Audits and maintains the functional "contract" between the Django (DRF) Backend and the Next.js Frontend. It prevents regressions caused by tier-mismatch, specifically targeting data structure changes and pagination logic.

## Contextual Triggers
- Modifying `views.py` (specifically `queryset` or `pagination_class`).
- Updating Serializers in `serializers.py` (renaming or removing fields).
- Adding new Master Data hooks in `frontend/lib/hooks/`.

## Audit Protocol
1.  **Endpoint Mapping**: 
    - Identify the Backend Viewset and its `pagination_class`.
    - Identify the Frontend hook (e.g., `useQuery`) calling this endpoint.
2.  **Structural Validation**:
    - If Backend is paginated: Hook must parse `{ results: T[] }`.
    - If Backend is flat: Hook must parse `T[]`.
3.  **Field Consistency**:
    - Compare `Serializer.Meta.fields` against the TypeScript `interface` in the frontend.
    - Check for "Read-only" vs "Write-only" mismatches in forms.
4.  **Parameter Parity**:
    - Ensure `get_queryset` query params match the `params` passed in the `api.get` call.

## Process
- **Step 1 (Scan)**: Locate the Backend ViewSet and Serializer.
- **Step 2 (Trace)**: find the API route in `urls.py`, then find the frontend hook calling that route.
- **Step 3 (Compare)**: Detect discrepancies in pagination, field names, or nesting.
- **Step 4 (Resolve)**: Propose a cross-tier fix (update both files simultaneously).

## Output
- A "Contract Audit Report" identifying potential breaking changes.
- Synchronized code that prevents "undefined" errors on the frontend.
