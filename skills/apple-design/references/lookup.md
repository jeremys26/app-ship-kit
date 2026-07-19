# Intent → HIG lookup

Prefix every slug with:
`https://developer.apple.com/design/human-interface-guidelines/`

Pick **one** primary page. Fetch it only if the task needs specifics.

---

## By job

| Intent | Open first | Then |
|--------|------------|------|
| New screen feels “not native” | `designing-for-ios` (or platform) | `layout`, `materials`, `typography` |
| Tab bar / bottom nav | `tab-bars` | `tab-views`, `sidebars` |
| Modal / sheet / form sheet | `sheets` | `modality` |
| Toolbar / nav chrome | `toolbars` | `navigation-bars`, `menus` |
| Buttons / CTAs | `buttons` | `menus`, `pop-up-buttons` |
| Lists / feeds | `lists-and-tables` | `scroll-views`, `progress-indicators` |
| Search UX | `searching` | `search-fields` |
| Text input | `text-fields` | `entering-data`, `keyboards` |
| Icons / SF Symbols | `sf-symbols` | `icons`, `app-icons` |
| App icon / Liquid Glass icon | `app-icons` | Resources → Icon Composer |
| Color / dark mode / glass | `color` | `materials`, `dark-mode` |
| Motion / transitions | `motion` | `playing-haptics`, Reduce Motion via `accessibility` |
| Typography / Dynamic Type | `typography` | `labels`, `writing` |
| Accessibility / VoiceOver | `accessibility` | `voiceover`, `writing`, `layout` |
| Onboarding / empty / help | `onboarding` | `offering-help`, `loading` |
| Settings screens | `settings` | `toggles`, `lists-and-tables` |
| Widgets | `widgets` | Resources Live Activities template |
| Live Activities / Dynamic Island | `live-activities` | |
| Notifications | `notifications` | |
| Paywalls / IAP | `in-app-purchase` | `ratings-and-reviews` |
| Sign in | `sign-in-with-apple` | `privacy` |
| Siri / shortcuts | `siri` | `app-shortcuts`, `snippets` |
| Generative AI UX | `generative-ai` | `machine-learning` |
| Games | `designing-for-games` | `game-controls`, `game-center` |
| watchOS | `designing-for-watchos` | `complications`, `digital-crown` |
| visionOS / spatial | `designing-for-visionos` | `ornaments`, `spatial-layout`, `immersive-experiences`, `eyes` |
| tvOS | `designing-for-tvos` | `focus-and-selection` |
| macOS | `designing-for-macos` | `the-menu-bar`, `windows`, `split-views` |
| iPad multitasking | `designing-for-ipados` | `multitasking`, `apple-pencil-and-scribble` |
| Design principles | `design-principles` | Pathway videos in [pathway.md](pathway.md) |
| What shipped recently | [What’s New](https://developer.apple.com/design/whats-new/) | |
| Download kits / fonts | [resources.md](resources.md) | |

---

## By HIG hub

| Hub | Use for | Slug |
|-----|---------|------|
| Getting started | Platform primers, where to begin | `getting-started` |
| Foundations | Color, type, layout, materials, a11y, icons | `foundations` |
| Patterns | Search, onboarding, modality, multitasking | `patterns` |
| Components | Buttons, bars, lists, controls | `components` |
| Inputs | Gestures, keyboards, pointer, eyes | `inputs` |
| Technologies | Pay, Siri, Widgets, Wallet, AI… | `technologies` |
| Platforms | Cross-links to platform pages | `platforms` |

---

## RN / Expo translation cheat sheet

| HIG idea | Typical Expo/RN move |
|----------|----------------------|
| Tab bars | Native tabs (`expo-router`) |
| Sheets | `formSheet` / native sheet |
| 44pt targets | `hitSlop` / min size on `Pressable` |
| SF Symbols | `expo-symbols` / `@expo/vector-icons` SF |
| Dynamic Type | allow font scaling; reflow rows |
| Reduce Motion | gate decorative Reanimated |
| Materials / Liquid Glass | Prefer system blur/native UI; don’t fake glass with random gradients |
| Haptics | `expo-haptics` on consequential actions only |

Deeper RN defaults live in **app-ship-kit** `mobile-ui.md` when that skill is installed.
