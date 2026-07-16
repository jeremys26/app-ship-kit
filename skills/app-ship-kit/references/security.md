# Security Checklist

Run when adding features, tables, endpoints, auth flows, or env vars. Distilled from real Expo + Supabase audits; adapt names to your stack.

---

## Stack rules (run these first)

### Database / RLS (Supabase Postgres or similar)

- [ ] **New public table?** Enable RLS + at least one policy. No naked public tables.
- [ ] **New RPC?** Never trust client-supplied `user_id` / org id for authorization — derive from `auth.uid()` (or session) inside the function.
- [ ] **SECURITY DEFINER?** Explicit revoke from `anon`/`authenticated` if not meant public; prefer INVOKER when possible; always `auth.uid()` guard inside.
- [ ] **Views?** `security_invoker = true` (PG15+) or wrap with an auth-checked function.
- [ ] **Never** use user-editable JWT `user_metadata` / `raw_user_meta_data` in RLS — use `app_metadata` or a profiles column.
- [ ] Soft `RETURN error` for unauthorized → prefer `RAISE EXCEPTION` so RLS remains authoritative.

### Edge functions / server routes

- [ ] **CORS:** no `*` on admin/cron; allowlist origins.
- [ ] **Auth-then-privilege:** resolve user with anon/user client + JWT first; construct service-role / admin client **only after** authorization succeeds.
- [ ] **Secret guards fail closed:** `if (!secret || incoming !== secret) return 401` — never `if (secret && …)` (unset env = open).
- [ ] **Errors to client:** generic message; log details server-side. Never `String(e)` / `err.message` in responses.
- [ ] Rate-limit sensitive writes (delete account, invite generation) at DB or gateway.

### Client (Expo / RN / web)

- [ ] **`EXPO_PUBLIC_` / `NEXT_PUBLIC_`:** public only. Never secrets, bypass codes, service keys, security feature flags.
- [ ] **CSPRNG** for tokens/invite codes: `crypto.getRandomValues` — never `Math.random()`.
- [ ] Ban `dangerouslySetInnerHTML` / `eval` unless sanitized and justified.
- [ ] **Open redirects:** `redirectTo` is a compile-time constant, not from query params.
- [ ] **DB-sourced URLs:** validate scheme (`https:`) before `Linking.openURL` / `window.open`.
- [ ] **Uploads:** server/bucket MIME allowlists; don't trust client `Content-Type` alone.

### Secrets hygiene

- [ ] `.env`, `.env.*`, `.env*.local` gitignored
- [ ] No signing certs / `.p8` / `.pem` / keystores committed
- [ ] Prod vs dev projects separated

---

## High-frequency vulnerability classes

Use as a review cheat sheet (not every item applies every stack):

| Class | Guard |
|-------|-------|
| Missing RLS / BOLA | Policies + `auth.uid()`; no "get by any UUID" RPCs |
| Privileged secrets in bundle | Audit `EXPO_PUBLIC_` / `NEXT_PUBLIC_` |
| Wildcard CORS | Allowlist |
| Soft auth returns | Raise / 401 |
| Fail-open secret checks | Fail closed when unset |
| Verbose errors | Generic client errors |
| Weak randomness | CSPRNG |
| Unrestricted uploads | MIME + size limits |
| Open redirect | Constant callback URLs |
| SSRF via server proxy | Admin-only + URL allowlist |
| Client-only rate limits | Server/DB throttle |
| Debug bypass in prod | `__DEV__` / build-profile gated |

For a longer vulnerability-class checklist when auditing a similar RN + Supabase stack, expand from the table above and from installed `insecure-defaults` / `differential-review` skills ([ecosystem.md](ecosystem.md)).

---

## Patterns to copy

**New table**
```sql
ALTER TABLE public.my_table ENABLE ROW LEVEL SECURITY;
CREATE POLICY "owner_select" ON public.my_table
  FOR SELECT TO authenticated
  USING ((SELECT auth.uid()) = user_id);
```

**Edge: two-client auth**
```ts
const userClient = createClient(url, ANON_KEY, {
  global: { headers: { Authorization: authHeader } },
});
const { data: { user } } = await userClient.auth.getUser();
if (!user) return err('Unauthorized', 401);
// only then:
const admin = createClient(url, SERVICE_ROLE_KEY);
```

**Invite / token**
```ts
const bytes = crypto.getRandomValues(new Uint8Array(length));
const code = Array.from(bytes, (b) => CHARS[b % CHARS.length]).join('');
```

---

## When to run

| Moment | Action |
|--------|--------|
| New table / RPC / edge function | Stack rules section |
| PR touching auth/DB/env | Stack rules + differential review if available |
| Pre-ship | Advisors + insecure-defaults scan + no auth-bypass / skip-auth flags in production |
