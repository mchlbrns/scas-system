# Brainstorm Report: Dynamic Client Template View

## Requirement Analysis
**Goal**: Create a dynamic view for Analysts to manage endorsements, based on a template configured by Admins for specific Clients.

**Core Components**:
1.  **Configuration (Admin)**:
    - Existing `ImportSchema` (Import Templates) defines how to ingest data.
    - **NEW**: Need a way to define the *Display View* for these endorsements. This might be part of the existing schema or a new "View Template".
    - *Assumption*: The user wants the Analyst's "Endorsement View" (likely a DataTable) to dynamically adapt columns based on the Client's specific requirements (defined in the template).

2.  **Execution (Analyst)**:
    - Analyst selects a Client (or is assigned one).
    - The "Endorsement View" loads the specific columns/layout defined for that Client.
    - Analyst starts the process (status transition?).

**Key Flows**:
1.  **Admin**: Creates/Edits a Template -> Assigns to Client -> Defines Visible Columns / Actions.
2.  **Analyst**: Navigates to "Endorsements" -> Selects Client -> Sees Dynamic Table -> Actions on Rows.

## Context Scan
- **Existing Import Config**: `frontend/app/dashboard/admin/import-config/page.tsx` uses `useImportSchemas`.
- **Backend Models**: Likely `ImportSchema` in `core` or `receivables`. Need to check `receivables` app for `Endorsement` or `Account` models.
- **Frontend Components**: `SchemaEditor` exists. `Sidebar` has "Import Templates" (Admin only) and "Accounts" (Analyst - restricted currently?). Wait, I just restricted "Accounts" for Analysts. The user wants them to verify endorsements. This implies a *new* view or re-enabling a modified "Endorsements" view.

## Edge Case Simulation
- **No Template**: What if an Analyst views a client with no template? -> Show default view or empty state?
- **Column Mismatch**: Template defines columns X, Y, Z, but data is missing? -> Backend should handle nulls, Frontend should render gracefully.
- **Permissions**: Analyst should only see clients they are assigned to.
- **Performance**: Dynamic columns in DataTables can be tricky with sorting/filtering.

## Implementation Strategy
### Option A: Extend ImportSchema
- Add `display_columns` to `ImportSchema`.
- Reuse the schema for both Import and Display.
- **Pros**: Single source of truth.
- **Cons**: Import fields != Display fields (internal IDs, calculated status).

### Option B: New `ViewTemplate` Model
- Decouple Import from Display.
- admin defines "Endorsement View" separately.
- **Pros**: Flexibility.
- **Cons**: More complexity.

**Recommendation**: Start with **Option A (Extension)**. The user calls it "Dynamic Template View". It likely maps closely to what was imported.

## Needed Actions
1.  **Backend**:
    - Check `ImportSchema` model. Add `is_active_view` or `display_config` JSONField.
    - Create/Update generic `EndorsementViewSet` to accept `client_id` and return dynamic data.
2.  **Frontend**:
    - Update `SchemaEditor` to allow selecting "View Columns".
    - Create `DynamicEndorsementPage` (Client Selection -> Dynamic Table).
