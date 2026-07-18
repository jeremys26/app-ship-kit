# Mobile UI — React Native / iOS defaults

Use with [ui.md](ui.md) (critique → polish → copy). These are **portable** rules that
work without installing upstream skills. When you need depth, see [ecosystem.md](ecosystem.md).

Respect project `DESIGN.md` tokens first — never invent a parallel palette.

---

## Native-feeling checklist (every screen)

- [ ] **Safe area:** `useSafeAreaInsets()` — no hard-coded notch offsets
- [ ] **Touch:** ≥ 44×44 pt hit targets; icon-only controls labeled
- [ ] **Press:** `Pressable` (not `TouchableOpacity`); spring ~0.97 or opacity feedback
- [ ] **Haptics:** consequential actions only (`expo-haptics` when available)
- [ ] **Lists:** virtualized list for unbounded data — never `ScrollView` + `.map()` for feeds
- [ ] **Images:** `expo-image` (caching) over RN `Image` when Expo is present
- [ ] **Motion:** animate `transform` + `opacity` only; gate decorative motion with Reduce Motion
- [ ] **One primary CTA** per viewport (accent from DESIGN.md)
- [ ] **Empty / loading / error** name the next action
- [ ] **Status not color-only** (icon/text + color)

---

## Navigation (Expo Router preferred)

| Pattern | Prefer |
|---------|--------|
| Tabs | Native tabs when available (`expo-router` native tabs) |
| Modals / sheets | Platform sheet / formSheet over custom full-screen hacks |
| Headers | Shared `stackScreenOptions`; large titles sparingly |
| Deep links | Typed routes; compile-time schemes — no open redirects |

If Expo Router is installed, prefer reading **`expo-router`** / **`expo-native-ui`** upstream over inventing nav.

---

## Lists & scroll (perf)

| Do | Don't |
|----|-------|
| FlashList / tuned FlatList for long lists | ScrollView of hundreds of rows |
| Stable `keyExtractor`; avoid inline `renderItem` objects that recreate every render | Anonymous object/style props that thrash |
| Skeleton height ≈ final row height | Layout jump on load |
| `windowSize` / `removeClippedSubviews` tuned after measuring | Premature micro-opts |

**Jank?** Measure first with Callstack `react-native-best-practices` (ecosystem) — don't guess.

---

## Animation (Reanimated)

- UI-thread worklets for gestures and continuous motion
- Prefer springs for press / sheet; avoid layout-property animation
- Honor Reduce Motion: skip enter loops, pulse rings, confetti
- One "hero" motion per screen max
- **Reanimated 4 needs `react-native-worklets` as an explicit dependency** (worklets moved out of the Reanimated package) **and a `babel.config.js`** with `babel-preset-expo` — missing either one fails silently in the Metro bundle rather than erroring at install. If a fresh Expo project has no `babel.config.js`, add one before debugging anything else.

Web motion skills (`fixing-motion-performance`) → translate to Reanimated/`transform`+`opacity`.

---

## Accessibility (iOS-first)

| Concern | RN habit |
|---------|----------|
| VoiceOver name | `accessibilityLabel` on icon buttons; don't nest conflicting roles |
| Traits | `accessibilityRole` (`button`, `header`, `tab`, …) |
| Dynamic Type | Allow font scaling; reflow rows at large sizes (stack horizontally → vertically) |
| Contrast | WCAG AA on canvas/panel tokens from DESIGN.md |
| Reduce Motion | Shared hook / MotionView wrapper |
| Hit slop | Expand small icons without growing visuals |

Deep audit / App Store a11y prep → **axiom-ios-accessibility** (ecosystem).

---

## Platform splits

- Shared components stay mobile-first
- Web/admin: `Platform.select` or `.web.tsx` — never compromise thumb reach for desktop hover
- Semantic / system colors: prefer Expo semantic tokens / HIG when `expo-native-ui` applies; else DESIGN.md

---

## Copy on mobile

Short. One idea per line. Imperative empty states ("Add your first item").  
De-slopify per [ui.md](ui.md) — no product-blog voice.

---

## Upstream depth map

| Need | Skill |
|------|-------|
| HIG / SF Symbols / native controls | `expo-native-ui` |
| File routes / native tabs / sheets | `expo-router` |
| Dense RN rule checklist | `vercel-react-native-skills` |
| FPS / TTI / bundle measurement | Callstack `react-native-best-practices` |
| VoiceOver / Dynamic Type audit | `axiom-ios-accessibility` |
| UI topic routing | `npx ui-skills start` |
