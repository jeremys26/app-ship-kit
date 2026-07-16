# Bootstrap — new repo / first week

Use when starting a greenfield app or dropping this kit into an existing repo.

---

## Checklist

- [ ] Install kit: `npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y`  
      or `./skills/app-ship-kit/scripts/setup.sh`
- [ ] Optional stack (pick one primary):
  - Expo + backend: `--stack expo-supabase`
  - Expo + perf: `--stack expo-mobile`
  - Near App Store: `--stack ios-ship`
- [ ] Create `.claude/DESIGN.md` from [design-brief-template.md](../assets/design-brief-template.md)
- [ ] Optional: append [AGENTS.snippet.md](../assets/AGENTS.snippet.md) to `AGENTS.md` / `CLAUDE.md`
- [ ] Copy [ship-checklist-template.md](../assets/ship-checklist-template.md) → `docs/ship-checklist.md` (adapt)
- [ ] Confirm `.env*` gitignored; no secrets with `EXPO_PUBLIC_` / `NEXT_PUBLIC_`
- [ ] Point agent at primary platform (iOS sim vs web) once

---

## Folder conventions (suggested, not required)

Adapt names to the stack; keep **layer discipline** from [architecture.md](architecture.md):

```text
app/ or screens/     # routes — thin
hooks/ or data/      # server state
lib/ or domain/      # pure logic
components/ui/       # shared chrome
supabase/migrations/ # if Supabase
```

---

## First three agent tasks (recommended order)

1. Fill DESIGN.md (tokens + primitives + do/don't).
2. Implement or harden auth session storage (SecureStore / httpOnly — stack-appropriate).
3. Add one vertical slice end-to-end with RLS + one smoke check ([testing.md](testing.md)).

---

## Done when

Peers can say `use app-ship-kit` and the agent routes to a pipeline without
pasting long prompts. Upstream packs are optional, not blocking.
