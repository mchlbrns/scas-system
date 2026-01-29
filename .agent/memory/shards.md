# Execution Shards: UI Modernization

## [SHARD-001] Backend Pagination Enablement
- **Description**: Remove `pagination_class = None` from `AnalystViewSet` to enable global pagination.
- **Target Files**: 
    - [analysts/views.py](file:///c:/Users/Geloo/Desktop/SCASI/analysts/views.py)
- **Dependencies**: None
- **Criteria**: `GET /api/v1/analysts/` returns a response with `count`, `next`, `previous`, and `results`.

## [SHARD-002] Pagination UI Component
- **Description**: Create a standalone pagination component.
- **Target Files**: 
    - [frontend/components/ui/Pagination.tsx](file:///c:/Users/Geloo/Desktop/SCASI/frontend/components/ui/Pagination.tsx) [NEW]
- **Dependencies**: None
- **Criteria**: Component renders UI for navigating pages and handles callbacks for page changes.

## [SHARD-003] Hook Updates (Master Data)
- **Description**: Update `useMasterData.ts` to support paginated responses.
- **Target Files**: 
    - [frontend/lib/hooks/useMasterData.ts](file:///c:/Users/Geloo/Desktop/SCASI/frontend/lib/hooks/useMasterData.ts)
- **Dependencies**: [SHARD-001]
- **Criteria**: Hooks return `data.results` (or the whole object) and accept optional `page` parameter.

## [SHARD-004] DataTable Enhancement
- **Description**: Add optional pagination controls to `DataTable`.
- **Target Files**: 
    - [frontend/components/tables/DataTable.tsx](file:///c:/Users/Geloo/Desktop/SCASI/frontend/components/tables/DataTable.tsx)
- **Dependencies**: [SHARD-002]
- **Criteria**: `DataTable` renders the `Pagination` component if `pagination` prop is provided.

## [SHARD-005] User Page Harmonization & Pagination
- **Description**: Refactor the Users page to use `DataTable` and server-side pagination.
- **Target Files**: 
    - [frontend/app/dashboard/admin/users/page.tsx](file:///c:/Users/Geloo/Desktop/SCASI/frontend/app/dashboard/admin/users/page.tsx)
- **Dependencies**: [SHARD-003], [SHARD-004]
- **Criteria**: Users page works correctly with search, sorting (server-side if possible, or local), and pagination.
