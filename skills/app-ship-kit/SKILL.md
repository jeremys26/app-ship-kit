---
name: app-ship-kit
description: >-
  Full-stack app ship operating system: routes feature work, UI polish, security,
  review, and release through Gather→Act→Verify pipelines. Use when building or
  hardening any app, starting a repo, bootstrapping agent setup, asking which
  skill to run, preparing TestFlight/App Store/web deploy, reviewing structure
  or over-engineering, adding RLS/tables/edge functions, writing minimal tests,
  or when the user says app-ship-kit, ship kit, use the app helper, ready to
  ship, bootstrap, or which pipeline.
license: MIT
metadata:
  openstandard: agentskills.io
  version: "0.4.0"
  stacks: expo, react-native, supabase, typescript
---

# App Ship Kit

Product-agnostic operating system for shipping apps. Defaults assume
**Expo / React Native + TypeScript + Supabase**; adapt when the repo is Next.js,
Workers, etc.

**Progressive disclosure:** read only the reference the current pipeline needs.
Do not load every file.

| Resource | When |
|----------|------|
| [references/philosophy.md](references/philosophy.md) | Writing/refactoring; YAGNI |
| [references/architecture.md](references/architecture.md) | Layers, file ratchet, code judo |
| [references/review.md](references/review.md) | Pre-merge review passes |
| [references/ui.md](references/ui.md) | Screens, polish, a11y, copy |
| [references/mobile-ui.md](references/mobile-ui.md) | RN/iOS native UI defaults |
| [references/testing.md](references/testing.md) | Minimum viable checks |
| [references/bootstrap.md](references/bootstrap.md) | New repo / first week |
| [references/examples.md](references/examples.md) | Concrete G→A→V walkthroughs |
| [assets/design-brief-template.md](assets/design-brief-template.md) | Missing DESIGN.md |
| [assets/ship-checklist-template.md](assets/ship-checklist-template.md) | Project ship checklist |
| [assets/AGENTS.snippet.md](assets/AGENTS.snippet.md) | Paste into AGENTS/CLAUDE.md |
| [references/security.md](references/security.md) | Auth, RLS, edge, env, uploads |
| [references/backend.md](references/backend.md) | Migrations, RPCs, Postgres |
| [references/ship.md](references/ship.md) | Store / web release readiness |
| [references/verify.md](references/verify.md) | Simulator / device smoke |
| [references/ecosystem.md](references/ecosystem.md) | Optional upstream skills |

---

## Gather → Act → Verify (every task)

### Gather

1. Detect stack (`app.json`/`expo`, `supabase/`, `next.config.*`, `wrangler.toml`).
2. Read project `DESIGN.md` / `.claude/DESIGN.md` if present; else offer the design-brief template.
3. Scope the ask to **one** pipeline below.

### Act

Climb [philosophy.md](references/philosophy.md), then execute only that pipeline.
For greenfield setup, start with [bootstrap.md](references/bootstrap.md) or run `scripts/setup.sh --init` from the app root.

### Verify

Run the pipeline's smoke check ([verify.md](references/verify.md), [testing.md](references/testing.md), or security/advisors). Report:
`[done] → skipped: [X], add when [Y].`

---

## Pipelines (pick one)

### A. Feature / bugfix

```
Trace flow → philosophy ladder → smallest correct diff
→ security.md if trust boundary → one check (testing.md)
```

### B. UI surface

```
DESIGN.md → critique (ui.md) → mobile-ui.md checklist
→ optional Apple HIG lookup (sibling skill apple-design)
→ polish (44pt, motion, loading) → de-slopify → verify
→ optional: expo-native-ui / Callstack / axiom (ecosystem.md)
```

### C. Backend / schema

```
backend.md → security.md → migration in git → advisors/types → RLS-safe client
```

### D. Pre-merge

```
Correctness → architecture (structure) → deletion pass (review.md)
→ security if auth/DB/env touched
```

### E. Ship / release

```
Copy + launch UI → DB/security gate → sim smoke → ship.md → human device QA
```

Optional depth: [ecosystem.md](references/ecosystem.md) or `scripts/setup.sh --stack expo-supabase`.
Walkthroughs: [examples.md](references/examples.md).

---

## Non-negotiables

Never simplify away: trust-boundary validation, session-derived authZ, data-loss
prevention, a11y basics, secrets out of public env prefixes, explicit user asks.

## Layer defaults

| Layer | Owns | Must not own |
|-------|------|--------------|
| Screens / routes | Composition, nav | Domain math, query defs |
| Data hooks | Fetch/mutate, cache keys | Duplicated key factories |
| Domain / `lib` | Pure logic | React/JSX |
| Client store | Ephemeral UI state | Server cache |
| UI kit | Shared chrome | Feature business rules |

**File-size ratchet:** new files < 1000 lines; over-cap files must not grow.

## Intensity

| Level | Behavior |
|-------|----------|
| **lite** | Build asked; name lazier alt in one line |
| **full** (default) | Ladder enforced |
| **ultra** | Challenge requirement; delete before add |

Stop: `stop ship kit` / `normal mode`.
