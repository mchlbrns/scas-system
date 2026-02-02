# Task Shards

## Shard 1: Backend Core [BLOCKING]
**Goal**: Update Data Model to support dynamic views.
**Files**:
- `receivables/models.py`: Add `display_config` to `ImportSchema`.
- `receivables/serializers.py`: Expose `display_config`.
- `receivables/views.py`: Ensure API saves this field.

## Shard 2: Admin Configuration [DEPENDS ON 1]
**Goal**: UI for Admins to configure specific column visibility.
**Files**:
- `frontend/components/accounts/SchemaEditor.tsx`: Add "View Settings" tab.
- `frontend/lib/hooks/useImportSchemas.ts`: Update types.

## Shard 3: Analyst View [DEPENDS ON 1]
**Goal**: Dynamic table for Analysts.
**Files**:
- `frontend/app/dashboard/endorsements/page.tsx`: New route.
- `frontend/components/dynamic/DynamicDataTable.tsx`: New component.
