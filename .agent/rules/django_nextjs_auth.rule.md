---
description: Enforce best practices for Django and Next.js authentication configuration
triggers:
  - When configuring Django settings.py or .env
  - When implementing Next.js authentication cookies
  - When setting up CORS or CSRF in Django
---
# Django & Next.js Authentication Configuration Rule

## Description
This rule enforces synchronization between Django CORS/CSRF settings and Next.js cookie security attributes. It prevents common issues where login fails due to protocol mismatches (HTTP vs HTTPS) or missing origin trusts.

## Rules

### 1. Conditional Secure Cookies
**Constraint**: Authentication cookies (e.g., JWT access/refresh tokens) MUST NOT have the `Secure` attribute hardcoded if the application is meant to run on HTTP (e.g., local IP testing).
**Requirement**: Use incorrect/conditional logic based on `window.location.protocol` or environment variables.

**Bad**:
```typescript
document.cookie = `token=${token}; Secure`;
```

**Good**:
```typescript
const isSecure = window.location.protocol === 'https:';
document.cookie = `token=${token}; ${isSecure ? 'Secure' : ''}`;
```

### 2. Synchronized CORS and CSRF Origins
**Constraint**: If `CORS_ALLOWED_ORIGINS` is set in Django, `CSRF_TRUSTED_ORIGINS` MUST also be configured to include the same origins (especially for Django 4.0+).
**Requirement**: Both settings should ideally read from the same source (e.g., `.env`) or be strictly synchronized.

**Bad**:
```python
CORS_ALLOWED_ORIGINS = ["http://localhost:3000"]
# CSRF_TRUSTED_ORIGINS missing or mismatching
```

**Good**:
```python
CORS_ALLOWED_ORIGINS = config('ALLOWED_ORIGINS', cast=csv)
CSRF_TRUSTED_ORIGINS = config('ALLOWED_ORIGINS', cast=csv)
```

### 3. IP Access Support
**Constraint**: When testing on local network IPs (e.g., `192.168.x.x`), both `127.0.0.1` and the specific IP MUST be explicitly added to `CORS_ALLOWED_ORIGINS` and `CSRF_TRUSTED_ORIGINS`.

## Verification
- [ ] Check if `Secure` flag is conditional in frontend code.
- [ ] Check if `CSRF_TRUSTED_ORIGINS` exists in `settings.py`.
- [ ] Verify `.env` contains all necessary origins (localhost, 127.0.0.1, LAN IP).
