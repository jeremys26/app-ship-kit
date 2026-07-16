# Ship checklist (template)

Copy to `docs/ship-checklist.md` and adapt. Simulator smoke ≠ store sign-off.

## Pre-build

- [ ] User-facing copy de-slopified (store, landing, help, push)
- [ ] Launch surfaces critiqued + polished (44pt, loading, reduce-motion)
- [ ] Migrations since last ship reviewed (RLS, advisors, types)
- [ ] No auth bypass / skip-auth in **production** profile
- [ ] Privacy usage strings match APIs actually used
- [ ] Account deletion path (if accounts exist) — App Store
- [ ] Sign in with Apple if other social login offered (iOS)
- [ ] Deep links / universal links smoke-tested
- [ ] Placeholder / TODO / lorem purged from user-facing strings

## Build

- [ ] Version / build number bumped
- [ ] Prod env sourced (no `.env.local` secrets in wrong profile)
- [ ] Privacy manifest / permissions reviewed

## Human device QA (required for stores)

On a production-like install (TestFlight / internal track):

- [ ] Auth + session persist across process kill
- [ ] Push receive + tap → correct screen (if applicable)
- [ ] Camera / payments / BLE if claimed in listing
- [ ] Offline → online flush (if offline is a feature)
- [ ] Fresh-account time-to-value path
- [ ] Two-device flows (invite, chat, trade) if applicable

## Verdict

```
SHIP: yes | no
Blockers:
- …
Follow-ups:
- …
```
