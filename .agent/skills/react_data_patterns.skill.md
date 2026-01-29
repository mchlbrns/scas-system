# React Data Patterns Skill

## Description
Standardizes the implementation of data fetching, state management, and API integration in the Next.js frontend using `@tanstack/react-query`. This ensures consistent behavior for Demo Mode, strict typing, and query caching across the application.

## Contextual Triggers
- Creating new data hooks (e.g., `use[Entity].ts`).
- Refactoring legacy API calls to use React Query.
- Adding "Demo Mode" support to existing pages.
- Standardizing return types for `DataTable` components.

## Standard Patterns
### 1. Imports & Setup
Always include these core dependencies:
```typescript
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import api from '@/lib/api';
import { useUIStore } from '@/store/uiStore';
import { useAuthStore } from '@/store/authStore';
```

### 2. Interface Definitions
Define strong types for the entity (Read) and input (Write).
```typescript
export interface Entity {
    id: number;
    // ... fields
    created_at: string;
}
```

### 3. The "Read" Hook (`useEntities`)
Must support:
- **Demo Mode**: Check `useUIStore`. Return local mock data if true.
- **Auth Checks**: `enabled: isDemoMode || (isAuthReady && isAuthenticated)`.
- **Query Key**: `['entities', params, isDemoMode]`.
- **Filtering**: Handle `search` and `status` in both Demo (local filter) and API (params).

**Template**:
```typescript
export function useEntities(params?: { search?: string, page?: number }) {
    const isDemoMode = useUIStore((state) => state.isDemoMode);
    const { isAuthReady, isAuthenticated } = useAuthStore();

    return useQuery({
        queryKey: ['entities', params, isDemoMode],
        queryFn: async () => {
            if (isDemoMode) {
                // Return MOCK_DATA filtered by params
                return { count: 0, results: [] }; 
            }
            const { data } = await api.get<{ results: Entity[] }>('/v1/entities/', { params });
            return data;
        },
        enabled: isDemoMode || (isAuthReady && isAuthenticated),
        staleTime: 60000,
    });
}
```

### 4. The "Write" Hooks (`useCreate`, `useUpdate`, `useDelete`)
- Must use `useMutation`.
- Must invalidate the relevant Query Key on success.

## Process
1.  **Define Types**: Create strict TypeScript interfaces for the API response.
2.  **Mock Data**: Ensure a standard mock set exists (or create one in `@/lib/demo-master-data`).
3.  **Implement Read Hook**: Follow the "Read" template above, ensuring Demo Mode is handled **inside** the `queryFn`.
4.  **Implement Write Hooks**: Create Mutation hooks that invalidate the list query.
5.  **Verify**: Check that the hook returns the correct `{ results: T[] }` structure expected by `DataTable`.

## Output
- A robust, typed custom hook file (e.g., `lib/hooks/useMyEntity.ts`).
- Seamless switching between Real API and Demo Mode.
