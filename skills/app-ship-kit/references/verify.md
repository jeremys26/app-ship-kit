# Verify — Simulator & Device Smoke

Use when asked to run the app, verify UI, test a feature, or capture screenshots. Prefer the **primary** platform the product ships on (for Expo apps: **iOS simulator**, not web).

---

## Runtime choice (Expo)

| Runtime | When | Command pattern |
|---------|------|-----------------|
| Expo Go | UI/product, most flows | `npx expo start --go` |
| Dev client | OAuth, deep links, native modules, push-like | `expo start --dev-client` after install |

Default to Expo Go unless the task needs the custom client.

---

## Generic smoke loop

1. Start Metro / dev server (auth bypass **only** if project documents a local-only flag)
2. Wait until bundler healthy
3. Open on booted simulator / emulator
4. Screenshot baseline
5. Exercise the path under test
6. Screenshot / a11y dump after
7. Note failures with repro steps

### iOS tooling (when available)

```bash
xcrun simctl list devices | grep Booted
# screenshots / UI dump via idb or simctl as project docs specify
```

Do not invent bundle IDs or URL schemes — read `app.json` / `app.config.*` (or native project files) in **this** repo.

---

## What to verify per change type

| Change | Smoke |
|--------|-------|
| UI polish | Target screen + primary CTA + dismiss + Reduce Motion if motion touched |
| Mutation | Optimistic UI → success → cache reflects; failure rolls back |
| Auth | Sign-in, kill app, still signed in; sign-out clears |
| Deep link | Cold start + warm open to correct screen |
| Offline queue | Enqueue offline → reconnect → flush → server truth |

---

## Accessibility quick pass

- [ ] Icon buttons labeled
- [ ] Hit targets ≥ 44pt on mobile
- [ ] Dynamic Type / large text does not clip critical CTAs (spot-check)
- [ ] Status not color-only

---

## Upstream verify tooling (optional)

| Tool | When |
|------|------|
| Kit loop above | Default on macOS with local Simulator |
| **Callstack** `react-native-best-practices` | Measure FPS/TTI before "optimizing" |
| **Argent** (Software Mansion) | Agent-driven tap/screenshot/profile — heavier MCP install |
| **eas-simulator** | Remote cloud sim (Linux/CI); not default on Mac |

See [ecosystem.md](ecosystem.md).

## Boundaries

- Simulator ≠ device QA for camera, push, StoreKit, BLE, performance under thermal load
- Never ship with local auth bypass enabled in production profiles ([ship.md](ship.md))
- Prefer project-specific verifier skill if one exists (bundle ID, scheme, idb ports)
