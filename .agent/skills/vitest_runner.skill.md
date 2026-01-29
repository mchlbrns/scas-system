# Vitest Runner Skill

## Description
This skill specializes in executing and debugging frontend tests using Vitest (and React Testing Library). It ensures that tests are run correctly within the Node.js environment, handling path resolutions and interpreting test results.

## Input
- Test Target (File path, directory, or specific test pattern).
- Context (Project root, frontend directory location).

## Process
1.  **Environment Check**:
    - Locate `package.json` to confirm `vitest` dependency and scripts (e.g., `npm test` or `npx vitest`).
    - Identify the frontend root directory (e.g., `frontend/`).
2.  **Path Resolution**:
    - Resolve relative paths from project root to the frontend directory.
    - Ensure test files match the `*.test.tsx` or `*.spec.ts` patterns.
3.  **Execution**:
    - Construct the test command.
    - If a specific file is provided: `npm test -- <path/to/file>`.
    - If a specific pattern is provided: `npm test -- -t "<pattern>"`.
    - Execute the command in the frontend directory.
4.  **Error Analysis**:
    - **ReferenceError/SyntaxError**: Suggest checking imports or environment/globals.
    - **AssertionError**: Highlight expected vs actual.
    - **SnapshotMismatch**: Suggest running with `-u` to update snapshots if intentional.
5.  **Output**:
    - Return success status and log output.
    - If failed, provide a diagnosis and suggested fix.

## Output
- **Test Report**:
    - Status: PASS/FAIL
    - Logs
    - Diagnosis (if fail)
