# HIG topic index

Base URL: `https://developer.apple.com/design/human-interface-guidelines/{slug}`

Slug rule: lowercase; spaces → `-`; `&` → `and`. Verified HTTP 200 on
**2026-07-19** unless marked otherwise.

---

## Hubs

| Title | Slug |
|-------|------|
| Getting started | `getting-started` |
| Foundations | `foundations` |
| Patterns | `patterns` |
| Components | `components` |
| Inputs | `inputs` |
| Technologies | `technologies` |
| Platforms | `platforms` |

Also live: `ios`, `macos`, `tvos`, `watchos` (short platform hubs).

---

## Platforms & games

| Title | Slug |
|-------|------|
| Designing for iOS | `designing-for-ios` |
| Designing for iPadOS | `designing-for-ipados` |
| Designing for macOS | `designing-for-macos` |
| Designing for tvOS | `designing-for-tvos` |
| Designing for visionOS | `designing-for-visionos` |
| Designing for watchOS | `designing-for-watchos` |
| Designing for games | `designing-for-games` |

---

## Foundations-leaning

| Title | Slug |
|-------|------|
| Accessibility | `accessibility` |
| App icons | `app-icons` |
| Branding | `branding` |
| Color | `color` |
| Dark Mode | `dark-mode` |
| Design principles | `design-principles` |
| Icons | `icons` |
| Images | `images` |
| Layout | `layout` |
| Materials | `materials` |
| Motion | `motion` |
| Privacy | `privacy` |
| Right to Left | `right-to-left` |
| SF Symbols | `sf-symbols` |
| Typography | `typography` |
| Writing | `writing` |

---

## Patterns-leaning

| Title | Slug |
|-------|------|
| Charting data | `charting-data` |
| Collaboration and sharing | `collaboration-and-sharing` |
| Drag and drop | `drag-and-drop` |
| Entering data | `entering-data` |
| Feedback | `feedback` |
| File management | `file-management` |
| Going full screen | `going-full-screen` |
| Launching | `launching` |
| Loading | `loading` |
| Modality | `modality` |
| Multitasking | `multitasking` |
| Offering help | `offering-help` |
| Onboarding | `onboarding` |
| Playing audio | `playing-audio` |
| Playing haptics | `playing-haptics` |
| Playing video | `playing-video` |
| Ratings and reviews | `ratings-and-reviews` |
| Searching | `searching` |
| Settings | `settings` |
| Undo and redo | `undo-and-redo` |

---

## Components-leaning

| Title | Slug |
|-------|------|
| Action button | `action-button` |
| Action sheets | `action-sheets` |
| Activity rings | `activity-rings` |
| Activity views | `activity-views` |
| Alerts | `alerts` |
| Boxes | `boxes` |
| Buttons | `buttons` |
| Charts | `charts` |
| Complications | `complications` |
| Context menus | `context-menus` |
| Controls | `controls` |
| Digital Crown | `digital-crown` |
| Edit menus | `edit-menus` |
| Gauges | `gauges` |
| Image views | `image-views` |
| Labels | `labels` |
| Lists and tables | `lists-and-tables` |
| Menus | `menus` |
| Navigation bars | `navigation-bars` |
| Ornaments | `ornaments` |
| Outline views | `outline-views` |
| Page controls | `page-controls` |
| Path controls | `path-controls` |
| Pickers | `pickers` |
| Popovers | `popovers` |
| Pop-up buttons | `pop-up-buttons` |
| Progress indicators | `progress-indicators` |
| Pull-down buttons | `pull-down-buttons` |
| Rating indicators | `rating-indicators` |
| Scroll views | `scroll-views` |
| Search fields | `search-fields` |
| Segmented controls | `segmented-controls` |
| Sheets | `sheets` |
| Sidebars | `sidebars` |
| Sliders | `sliders` |
| Split views | `split-views` |
| Status bars | `status-bars` |
| Steppers | `steppers` |
| Tab bars | `tab-bars` |
| Tab views | `tab-views` |
| Text fields | `text-fields` |
| Text views | `text-views` |
| The menu bar | `the-menu-bar` |
| Toggles | `toggles` |
| Toolbars | `toolbars` |
| Windows | `windows` |

---

## Inputs-leaning

| Title | Slug |
|-------|------|
| Apple Pencil and Scribble | `apple-pencil-and-scribble` |
| Camera Control | `camera-control` |
| Eyes | `eyes` |
| Focus and selection | `focus-and-selection` |
| Game controls | `game-controls` |
| Gestures | `gestures` |
| Keyboards | `keyboards` |
| Pointing devices | `pointing-devices` |
| Virtual keyboards | `virtual-keyboards` |

---

## Technologies-leaning

| Title | Slug |
|-------|------|
| AirPlay | `airplay` |
| Always On | `always-on` |
| App Clips | `app-clips` |
| App Shortcuts | `app-shortcuts` |
| Apple Pay | `apple-pay` |
| CareKit | `carekit` |
| CarPlay | `carplay` |
| Game Center | `game-center` |
| Generative AI | `generative-ai` |
| HealthKit | `healthkit` |
| HomeKit | `homekit` |
| iCloud | `icloud` |
| ID Verifier | `id-verifier` |
| iMessage apps and stickers | `imessage-apps-and-stickers` |
| In-app purchase | `in-app-purchase` |
| Live Activities | `live-activities` |
| Mac Catalyst | `mac-catalyst` |
| Machine learning | `machine-learning` |
| Maps | `maps` |
| Nearby interactions | `nearby-interactions` |
| Notifications | `notifications` |
| ResearchKit | `researchkit` |
| SharePlay | `shareplay` |
| Sign in with Apple | `sign-in-with-apple` |
| Siri | `siri` |
| Snippets | `snippets` |
| System experiences | `system-experiences` |
| Tap to Pay on iPhone | `tap-to-pay-on-iphone` |
| VoiceOver | `voiceover` |
| Wallet | `wallet` |
| Widgets | `widgets` |

Spatial / vision extras often paired with technologies & foundations:

| Title | Slug |
|-------|------|
| Immersive experiences | `immersive-experiences` |
| Spatial layout | `spatial-layout` |

---

## Retired / unresolved (appeared in What’s New history; 404 on index date)

| Title | Tried slug | Note |
|-------|------------|------|
| Messages for Business | `messages-for-business` | Page gone or renamed — search What’s New / docs |
| Touch Bar | `touch-bar` | Page gone — Touch Bar hardware deprecated |

---

## Maintenance

When Apple adds pages:

1. Confirm `GET …/human-interface-guidelines/{slug}` → 200
2. Add a row under the closest section above
3. Add an intent row in [lookup.md](lookup.md) if it is a common job
4. Bump `metadata.indexed` in `SKILL.md`
