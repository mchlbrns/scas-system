# Django Test Specialist Skill

## Description
This skill specializes in executing and debugging tests within a Django environment. It ensures that tests are run using the correct runner (`manage.py test` vs `pytest`) and resolves common configuration issues like import errors or database setup failures.

## Input
- Test Target (App name, file path, or specific test case).
- Context (Framework version, existing configuration files like `pytest.ini`).

## Process
1.  **Environment Check**:
    - Check for `manage.py` and `pytest.ini`.
    - Determine the preferred runner. Priority: `pytest` (if configured) > `manage.py test`.
2.  **Path Resolution**:
    - Convert relative file paths (e.g., `core/tests.py`) to dot-notation (e.g., `core.tests`) if using `manage.py`.
    - Differentiate between running a file, a class, or a method.
3.  **Execution**:
    - Run the test command.
    - Capture output (stdout/stderr).
4.  **Error Analysis**:
    - **ImportError**: Suggest converting relative imports to absolute or checking `PYTHONPATH`.
    - **AppRegistryNotReady**: Suggest using `manage.py` or configuring `DJANGO_SETTINGS_MODULE`.
    - **DatabaseError**: Suggest checking usage of `TestCase` (transactional) vs `TransactionTestCase`.
5.  **Output**:
    - Return success status and log output.
    - If failed, provide a diagnosis and a suggested fix command.

## Output
- **Test Report**:
    - Status: PASS/FAIL
    - Logs
    - Diagnosis (if fail)
