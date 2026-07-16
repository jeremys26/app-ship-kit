# Ship Gate

Pre-release workflow. **Does not replace** human device QA for store builds.

```
DESIGN + de-slopify (copy)
    → critique launch surfaces
    → polish top issues
    → backend/security if schema changed
    → simulator smoke (verify.md)
    → this checklist
    → human device QA on real build
```

---

## Pre-build code pass

1. **Copy** — store listing, landing, help, push strings ([ui.md](ui.md) de-slopify)
2. **UI** — critique onboarding + primary money paths + screenshot frames
3. **Polish** — 44pt, loading, reduce-motion on those surfaces
4. **Perf** (RN) — profile scroll jank on main feeds/lists before guessing
5. **DB** — [backend.md](backend.md) + [security.md](security.md) if migrations since last ship
6. Optional: stack packs from [ecosystem.md](ecosystem.md) (Expo/Supabase/security) if not already installed
7. Optional: scoped lint / react-doctor — high-confidence only

---

## Build profile hygiene

- [ ] No auth bypass / skip-auth flags in **production** profiles
- [ ] No dev secrets in prod env
- [ ] Version / build number bumped per store rules
- [ ] Privacy usage strings match actual APIs (camera, photos, tracking, etc.)
- [ ] Account deletion path exists if accounts are created (App Store)
- [ ] Sign in with Apple if other third-party login is offered (iOS policy)
- [ ] Deep links / universal links smoke-tested
- [ ] Push entitlements + server respect notification toggles

---

## App Store / Play preflight (agent)

1. Kit checklist above + [ship-checklist-template.md](../assets/ship-checklist-template.md)
2. If Expo: prefer installed **`eas-app-stores`** (via `expo/skills`) for build/submit/versioning
3. If available: **`app-store-preflight-skills`** for rejection patterns (privacy, entitlements, login, IAP)
4. Optional ASO/metadata: `asc` CLI + app-store-connect-cli-skills

Install pack: `./scripts/setup.sh --stack ios-ship` (see [ecosystem.md](ecosystem.md)).

Placeholder copy, lorem, and "TODO" in user-facing strings = ship blocker.

---

## Web deploy (if any)

- [ ] Landing conversion basics (one job per section; hero not a dashboard)
- [ ] Web quality pass (perf, a11y, SEO) on marketing routes
- [ ] Env sourced correctly; no service keys in client bundle

---

## Device QA (human — required for stores)

Simulator is **not** sufficient for sign-off. On a production-like install:

- [ ] Auth + session persist across kill
- [ ] Push receive + tap → correct screen
- [ ] Camera / QR / payments if claimed
- [ ] Offline → online flush if offline is a feature
- [ ] Fresh-account time-to-value path
- [ ] Two-device flows (invite, trade, chat) when relevant

Keep a project `docs/ship-checklist.md` (start from
[ship-checklist-template.md](../assets/ship-checklist-template.md)) and link it from your ship docs.

---

## Ready? Verdict format

```
SHIP: yes | no
Blockers:
- …
Follow-ups (non-blocking):
- …
```

If no: fix blockers before cutting the store build.
