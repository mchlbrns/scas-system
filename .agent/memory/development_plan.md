# Development Plan - Eliminate Outer Scroll & Implement Pagination

## Architecture Overview
- **Goal**: Eliminate the vertical scrollbar on the main dashboard content area ("outer element") by reducing the content height.
- **Method**: Implement client-side pagination for the `ClientPerformance` table.
- **Component Changes**:
    - `DataTable.tsx`: Add logic to slice `sortedData` when `pagination` props are provided.
    - `ClientPage` (`page.tsx`): Manage pagination state (`currentPage`, `itemsPerPage`) and pass it to `DataTable`.

## Worker Assignment
- **Agent**: Antigravity (Current Identity).
- **Task**: Modify `DataTable` and `ClientPage`.

## Risk Assessment
- **Edge Cases**:
    - **No Data**: Handled by existing `EmptyState`.
    - **Single Page**: `Pagination` component auto-hides or disables controls (checked implementation: returns null if `totalPages <= 1`).
    - **Sorting**: Handled by slicing *after* sorting.

## Success Criteria
- The "Client Performance" table shows a maximum of 10 rows per page.
- Pagination controls appear at the bottom of the table.
- The main content area no longer overflows the viewport on standard displays (1080p, 1440p), eliminating the outer scrollbar.
