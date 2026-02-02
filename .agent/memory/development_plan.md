# Development Plan: Dynamic Client Template View

## Architecture Overview
Enable specific Clients to have custom "Endorsement Views" configured by Admins. This view will dynamically render columns based on an `ImportSchema` or a dedicated `ViewConfiguration`.

**Approach**: Extend the existing `ImportSchema` to also serve as a "View Template". Admins will toggle which imported fields are visible in the Analyst's dashboard and define the order.

## Worker Assignment
### Phase 1: Backend Core (Schema Extension)
- **Task 1.1**: Modify `ImportSchema` model in `receivables` (or `core`) to include `display_config` (JSONField).
- **Task 1.2**: Update Serializers to read/write this config.
- **Task 1.3**: Create `DynamicEndorsementView` in backend that returns data shaped by this config.

### Phase 2: Frontend Admin (Configuration)
- **Task 2.1**: Update `SchemaEditor` to allow Admins to select "Visible Columns" and "Order".
- **Task 2.2**: Integrate with `useImportSchemas` hook.

### Phase 3: Frontend Analyst (Consumption)
- **Task 3.1**: Create `app/dashboard/endorsements/[clientId]/page.tsx`.
- **Task 3.2**: Implement `DynamicDataTable` component that takes `schema` + `data` and renders the grid.
- **Task 3.3**: Add "Start Process" action (simple status update for now).

## Risk Assessment
- **Complexity**: Dynamic tables are harder to type-check.
- **Data Integrity**: If schema changes, old data might not match. *Mitigation*: Schema versioning or loose parsing.
- **Performance**: Large JSON configs might slow down list API.

## Success Criteria
1.  Admin can tick "Show in Dashboard" for specific columns in `ImportSchema`.
2.  Analyst selects a specific Client.
3.  Analyst sees a DataTable with ONLY the configured columns.
4.  Analyst can click "Start Process" on a row.
