# Brainstorm Report: Auth Endpoints Configuration

## Architectural Approach
To satisfy the requirement of "permanently configuring" `api/token/` endpoints while maintaining existing functionality:
1.  **Add Aliases**: explicit paths for `api/token/` and `api/token/refresh/` in `dcms/urls.py`.
2.  **Preserve Logic**: Use `CustomTokenObtainPairView` for the new `api/token/` endpoint to ensure Audit Logs (Login events) are captured regardless of which endpoint is used.
3.  **Standard Components**: Use `TokenRefreshView` for the refresh endpoint (standard SimpleJWT behavior).

## Edge Cases & Risks
-   **Name Collision**: Existing paths use names `token_obtain_pair` and `token_refresh`. We should check if we can reuse the names or if we need aliases. Django URL names should be unique if we want reverse lookup to be unambiguous, but for incoming requests it doesn't matter. I will use standard names for `api/token/` (as `api/token` is the standard) and perhaps rename the custom ones or just leave them.
    -   *Decision*: I'll strictly add the paths. Explicit is better than implicit.
-   **Frontend Impact**: The current frontend uses `api/auth/login/`. Adding `api/token/` will safe-guard against external consumers or future refactors without breaking current usage.

## Recommended Libraries
-   `rest_framework_simplejwt` (Already installed).

## Implementation Strategy
1.  **Modify `dcms/urls.py`**: Insert the new paths.
