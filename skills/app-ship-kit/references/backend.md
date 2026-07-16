# Backend — Supabase / Postgres

Use when adding migrations, RLS, RPCs, edge functions, or hot-path queries. Prefer project MCP (`list_tables`, `get_advisors`, `apply_migration`) over guessing schema.

---

## Agent workflow

1. Inspect tables / RLS status
2. Pull security + performance advisors
3. Draft SQL in `supabase/migrations/` (timestamp prefix) — review in repo before apply
4. Policies use `auth.uid()` — never client-trusted identity for writes
5. Indexes on FKs used in list/feed/ranking queries
6. Regenerate types (`gen:types` or `supabase gen types`)
7. Smoke any grant/RLS scripts the repo provides

---

## Policy patterns

| Pattern | Rule |
|---------|------|
| Own rows | `user_id = auth.uid()` on CRUD |
| Public read | Authenticated SELECT; strip PII via views if needed |
| Org / crew scope | Join membership table where member is `auth.uid()` |
| Admin | Server-side admin flag check — never ship service role to client |
| Rate limits | Prefer DB triggers; client detects and surfaces errors |

### Never

- Service role key in client or public env
- Disable RLS "temporarily" on production
- Apply remote migrations without reviewing SQL in git
- Rely on `REVOKE FROM PUBLIC` alone — revoke `anon`/`authenticated` explicitly when needed

---

## RPC / transaction habits

- Multi-row related writes → **one RPC / transaction** (avoid partial failure)
- Rematches / upserts: define conflict behavior explicitly
- Prefer `SECURITY INVOKER` unless DEFINER is required and gated

---

## Edge functions

| Concern | Pattern |
|---------|---------|
| User-triggered | JWT via anon client → authorize → optional service role |
| Cron | Shared secret or internal invoke; fail closed if secret missing |
| Email | Follow deliverability basics (SPF/DKIM/DMARC are ops); no PII in logs |
| Push | Respect user notification toggles; skip muted / blocked |

---

## Migration checklist

- [ ] File in `supabase/migrations/` with timestamp
- [ ] RLS + policies for new tables
- [ ] Indexes for hot filters/joins
- [ ] Advisors clean after apply
- [ ] Types regenerated
- [ ] Client queries remain RLS-safe (no leaking other users' rows)

---

## Perf notes

- Select only needed columns on hot paths
- Avoid N+1: batch or join
- Parallelize independent client fetches with `Promise.all`
- Cache keys: one factory module — no shape drift between invalidate and fetch

For deep Postgres patterns, install/read `supabase-postgres-best-practices` upstream skill.
