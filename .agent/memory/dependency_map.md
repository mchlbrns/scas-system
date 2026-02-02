# Dependency Map: Dynamic Client Templates

## Impact Analysis
### Backend
- **Apps**: `core` (likely logic), `receivables` (ImportSchema model).
- **Files**:
    - `receivables/models.py` (Modify `ImportSchema`)
    - `receivables/serializers.py` (Update `ImportSchemaSerializer`)
    - `receivables/views.py` (New `DynamicEndorsementViewSet`?)

### Frontend
- **Apps**: `dashboard`
- **Files**:
    - `frontend/app/dashboard/admin/import-config/page.tsx` (Update UI)
    - `frontend/components/accounts/SchemaEditor.tsx` (Add View Config)
    - `frontend/app/dashboard/endorsements/page.tsx` (NEW: Dynamic View)
    - `frontend/lib/hooks/useImportSchemas.ts` (Update Hook)

## Collision Detection
- **Import Config**: `import-config/page.tsx` is relatively stable, but we modified `Sidebar.tsx` recently. No direct collision there.
- **Analyst Role**: We recently blocked "Accounts". This new feature likely replaces that with a "Dynamic Endorsement View".

## Execution Order
1.  **Backend Models**: specificall `ImportSchema`.
2.  **frontend Hooks**: Sync types.
3.  **Frontend Admin UI**: Update `SchemaEditor` to save display preferences.
4.  **Frontend Analyst UI**: Create the consumption view.
