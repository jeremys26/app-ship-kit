# Bootstrap — new project

Use when starting a greenfield app or adding this kit to an existing repo.

---

## Fastest path (recommended)

From the **app repository root**:

```bash
npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y
```

Then either:

**A — Scaffold with the setup script** (if you have a local clone of this kit):

```bash
/path/to/app-ship-kit/skills/app-ship-kit/scripts/setup.sh --init
# optional:
/path/to/app-ship-kit/skills/app-ship-kit/scripts/setup.sh --stack expo-supabase
```

**B — Ask the agent** (after install):

```text
use app-ship-kit — bootstrap this new project
```

The agent should: create `.claude/DESIGN.md` from the design-brief template (if missing),
offer the AGENTS snippet, and optionally suggest one `--stack` pack.

---

## Checklist

- [ ] Skill installed (`npx skills add …` or `setup.sh`)
- [ ] `.claude/DESIGN.md` filled (brand, tokens, do/don't) — template in `assets/design-brief-template.md`
- [ ] `AGENTS.md` (or `CLAUDE.md`) mentions app-ship-kit — see `assets/AGENTS.snippet.md`
- [ ] Optional: `docs/ship-checklist.md` from `assets/ship-checklist-template.md`
- [ ] Optional stack (pick **one** primary):
  - Expo + backend: `--stack expo-supabase`
  - Expo + perf: `--stack expo-mobile`
  - Near App Store: `--stack ios-ship`
- [ ] `.env*` gitignored; no secrets in `EXPO_PUBLIC_` / `NEXT_PUBLIC_`
- [ ] Tell the agent the primary platform once (iOS simulator vs web)

---

## Folder conventions (suggested, not required)

Adapt names to your stack; keep **layer discipline** from [architecture.md](architecture.md):

```text
app/ or screens/     # routes — thin
hooks/ or data/      # server state
lib/ or domain/      # pure logic
components/ui/       # shared chrome
supabase/migrations/ # if Supabase
```

---

## First three agent tasks

1. Fill DESIGN.md (tokens + primitives + do/don't).
2. Harden auth session storage for the stack (SecureStore / httpOnly cookies / etc.).
3. One vertical slice end-to-end with authZ + one smoke check ([testing.md](testing.md)).

---

## Done when

Saying `use app-ship-kit` routes work without pasting long prompts. Upstream packs are optional.
