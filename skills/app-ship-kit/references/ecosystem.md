# Ecosystem — curated upstream (RN / iOS / UI)

This kit is a **router**. Install upstream only when a pipeline needs depth.
Prefer **official / high-install** sources. Browse: [skills.sh](https://skills.sh) · `npx skills find <query>`

Install counts below are approximate (skills.sh, mid-2026) — use for signal, not gospel.

---

## Tier 0 — kit alone (default)

Enough for feature work, UI polish, security, review, ship checklists.

```bash
npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y
# or: ./skills/app-ship-kit/scripts/setup.sh
```

---

## Tier 1 — stack packs (one command)

| Pack | Command | What you get |
|------|---------|--------------|
| **expo-supabase** | `./scripts/setup.sh --stack expo-supabase` | Official Expo skills + Supabase skills |
| **expo-mobile** | `./scripts/setup.sh --stack expo-mobile` | Expo skills + Callstack RN perf |
| **ios-ship** | `./scripts/setup.sh --stack ios-ship` | Expo skills + App Store preflight |
| **perf** | `./scripts/setup.sh --stack perf` | Callstack RN best practices only |
| **security** | `./scripts/setup.sh --stack security` | Trail of Bits insecure-defaults + differential-review |

Manual equivalents are in each section below.

---

## React Native & Expo (build)

| Skill | Installs (approx) | Install | Use when | Kit pipeline |
|-------|-------------------|---------|----------|--------------|
| **expo/skills** (official) | — | `npx skills add expo/skills -y` | Router, native UI/HIG, data fetching, SDK upgrade, `@expo/ui`, EAS | B, C, E, verify |
| → `expo-native-ui` | | (in expo/skills) | Apple HIG styling, SF Symbols, semantic colors, native controls | B |
| → `expo-router` | | | Native tabs, stacks, sheets, headers | B |
| → `expo-data-fetching` | | | React Query / SWR / offline / loaders | A, C |
| → `expo-dev-client` | | | Custom dev client / internal TestFlight | E, verify |
| → `eas-app-stores` | | | Production build, TestFlight, store submit, ASO | E |
| → `eas-workflows` | | | CI YAML for EAS | E |
| → `eas-simulator` | | | **Remote** cloud sim (Linux/CI) — not default on macOS | verify |
| → `expo-upgrade` | | | SDK bumps | A |
| **vercel-react-native-skills** | ~167k | `npx skills add vercel-labs/agent-skills --skill vercel-react-native-skills -y` | FlashList, Pressable, expo-image, Reanimated patterns | A, B |
| **react-native-best-practices** (Callstack) | ~20k | `npx skills add callstackincubator/agent-skills --skill react-native-best-practices -y` | Profile-first FPS/TTI/bundle; measurement before fixes | B→perf, verify |
| **upgrading-react-native** (Callstack) | ~7k | `npx skills add callstackincubator/agent-skills --skill upgrading-react-native -y` | RN version upgrades | A |
| **react-native-architecture** (wshobson) | ~12k | `npx skills add wshobson/agents --skill react-native-architecture -y` | Greenfield Expo structure, offline-first patterns | bootstrap |
| **react-native-design** (wshobson) | ~12k | `npx skills add wshobson/agents --skill react-native-design -y` | StyleSheet / Reanimated / nav patterns | B — prefer `expo-native-ui` if Expo |

**Conflict rule:** For day-to-day RN UI patterns prefer **Expo official** + kit [mobile-ui.md](mobile-ui.md). For **jank / FPS / TTI** prefer **Callstack** (measure first). Add Vercel rules if you want a dense checklist and Expo skills aren't installed. Do **not** install Callstack + Vercel + wshobson design all at once.

---

## UI / UX (design & polish)

| Skill / tool | Install | Use when | Notes |
|--------------|---------|----------|-------|
| Kit [ui.md](ui.md) + [mobile-ui.md](mobile-ui.md) | (built-in) | Critique → polish → copy | Always first |
| **ui-skills** CLI | `npx ui-skills start` | "Which UI skill?" / motion / a11y routing | Translate web (ARIA/Tailwind) → RN props; **skip** `baseline-ui` unless NativeWind |
| **expo-native-ui** | via expo/skills | Native-feeling screens, HIG | Best Expo UI depth |
| **axiom-ios-accessibility** | `npx skills add charleswiltgen/axiom --skill axiom-ios-accessibility -y` | VoiceOver, Dynamic Type, App Store a11y review | Complements kit Pass 6 |
| **ios-accessibility** (Swift-focused) | `npx skills add dpearson2699/swift-ios-skills --skill ios-accessibility -y` | Higher install count (~3k); useful if auditing native SwiftUI / pure iOS a11y | Prefer for native iOS; Axiom for broader xOS router |
| **sleek-design-mobile-apps** | `npx skills add sleekdotdesign/agent-skills --skill sleek-design-mobile-apps -y` | Mockups / early visual exploration | **Paid API** (`SLEEK_API_KEY`); not for production code polish |

**Avoid by default:** generic "frontend-design" / random palette skills, `expo-tailwind-setup` unless the project already chose NativeWind, web-only `baseline-ui`.

---

## iOS ship & App Store

| Skill | Install | Use when |
|-------|---------|----------|
| **eas-app-stores** | via `expo/skills` | TestFlight, store submit, versioning, metadata |
| **app-store-preflight-skills** | `npx skills add truongduy2611/app-store-preflight-skills -y` | Pre-submit rejection patterns (privacy, entitlements, login, IAP) |
| **app-store-connect-cli-skills** | `npx skills add rudrankriyam/app-store-connect-cli-skills -y` | `asc` CLI metadata / ASO (optional; needs `brew install asc`) |

Pair with kit [ship.md](ship.md) + human device QA. Preflight does **not** replace device QA.

---

## Verify / drive the simulator

| Tool | Install | Use when |
|------|---------|----------|
| Kit [verify.md](verify.md) | built-in | Default local sim smoke |
| **Argent** (Software Mansion) | [argent.swmansion.com](https://argent.swmansion.com/) | Agent taps, screenshots, profiles RN on sim/device — heavier MCP toolkit |
| **eas-simulator** | via expo/skills | Remote cloud sim only |

Argent is optional power-tooling; do not require it for peers.

---

## Security & backend (unchanged high-signal)

| Skill | Install | Use when |
|-------|---------|----------|
| **supabase/agent-skills** | `npx skills add supabase/agent-skills -y` | Auth, RLS, Edge, Realtime |
| **insecure-defaults** | `npx skills add trailofbits/skills --skill insecure-defaults -y` | Fail-open secrets / CORS |
| **differential-review** | `npx skills add trailofbits/skills --skill differential-review -y` | Auth/RLS PR diffs |

---

## Intent → what to load

| User intent | Load first | Then (if installed) |
|-------------|------------|---------------------|
| New screen / polish | DESIGN.md → ui.md → mobile-ui.md | expo-native-ui |
| Scroll jank / slow TTI | verify → **Callstack** (measure) | vercel list rules |
| Navigation / tabs / sheets | mobile-ui.md | expo-router |
| VoiceOver / Dynamic Type | ui.md Pass 6 | axiom-ios-accessibility |
| TestFlight / App Store | ship.md | eas-app-stores → app-store-preflight |
| Data / offline / React Query | backend patterns | expo-data-fetching |
| "Which UI skill?" | `npx ui-skills start` | map result → RN |
| Agent drive sim autonomously | verify.md | Argent |

---

## How it fits the kit

```
app-ship-kit          → which pipeline (A–E)
DESIGN + philosophy   → constraints + minimal diffs
mobile-ui.md          → RN/iOS defaults without installs
ecosystem pack        → official Expo / Callstack / a11y / store depth
verify + ship         → smoke + human QA
```

If an upstream skill is **not** installed: follow kit references and suggest the one-line install — **do not block** the task.

---

## MCP (optional)

| Tool | Use with |
|------|----------|
| Expo MCP | Live docs, `expo install`, EAS from agent |
| Supabase MCP | `list_tables`, `get_advisors`, migrations |
| Argent MCP | Sim control / profiling |
| Cursor `/review-security` | Complements pass D |

---

## Do not install by default

| Source | Why |
|--------|-----|
| Full Trail of Bits suite | Pick named skills |
| Callstack **and** Vercel **and** wshobson design together | Overlap / context bloat — pick primary |
| Sleek without a design-exploration need | Paid; mockups ≠ implementation |
| Vendored copies of upstream into this repo | Stale; link + `npx skills add` |
| Secondsky / random "RN specialist" forks | Prefer Expo + Callstack + Vercel |
