---
name: apple-design
description: >-
  Apple Design hub index and HIG lookup for iOS/iPadOS/macOS/watchOS/tvOS/visionOS.
  Use when designing or polishing Apple-platform UI, checking Human Interface
  Guidelines, Liquid Glass / materials / app icons, SF Symbols, design kits,
  Icon Composer, or when the user says apple-design, HIG, Human Interface
  Guidelines, Apple Design resources, or What’s new in design. Complements
  app-ship-kit pipeline B (UI surface).
license: MIT
metadata:
  openstandard: agentskills.io
  version: "0.1.0"
  source: "https://developer.apple.com/design/"
  indexed: "2026-07-19"
---

# Apple Design

Navigational skill for [Apple Design](https://developer.apple.com/design/).
Indexes the five hub tabs and maps intents → live HIG URLs. **Do not paste
copyrighted Apple guideline prose into the repo.** Prefer project `DESIGN.md`
tokens; use this skill to find the right official page and apply it.

**Progressive disclosure:** read only the reference you need.

| Resource | When |
|----------|------|
| [references/index.md](references/index.md) | Five-tab map + tools on Overview |
| [references/lookup.md](references/lookup.md) | Intent → HIG page (start here for UI work) |
| [references/hig-topics.md](references/hig-topics.md) | Full topic index + URL slugs |
| [references/pathway.md](references/pathway.md) | Design Pathway / Get Started |
| [references/resources.md](references/resources.md) | UI kits, fonts, SF Symbols, Icon Composer |

---

## Gather → Act → Verify

### Gather

1. Confirm Apple-platform UI (Expo/RN, SwiftUI, or marketing for Apple devices).
2. Read project `DESIGN.md` / `.claude/DESIGN.md` if present.
3. Name the **one** design question (component, pattern, platform, or resource).

### Act

1. Open [references/lookup.md](references/lookup.md); pick the best HIG URL.
2. Fetch the live page when detail matters (Liquid Glass, iOS 27 kits, new components).
3. Translate guidance into the smallest UI diff that matches `DESIGN.md`.
4. For kits/fonts/symbols/icons → [references/resources.md](references/resources.md).
5. For “what changed?” → [What’s New](https://developer.apple.com/design/whats-new/) (live).

### Verify

- Touch targets ≥ 44×44 pt; VoiceOver labels; Dynamic Type; Reduce Motion.
- Status not color-only; one primary CTA per viewport.
- If using **app-ship-kit**, finish with its UI polish checklist (`ui.md` / `mobile-ui.md`).

---

## Hub tabs (canonical)

| Tab | URL |
|-----|-----|
| Overview | https://developer.apple.com/design/ |
| What’s New | https://developer.apple.com/design/whats-new/ |
| Get Started | https://developer.apple.com/design/get-started/ |
| Guidelines (HIG) | https://developer.apple.com/design/human-interface-guidelines/ |
| Resources | https://developer.apple.com/design/resources/ |

HIG topic URLs: `https://developer.apple.com/design/human-interface-guidelines/{slug}`

---

## Fetch notes

Apple’s HIG is a DocC SPA. Markdown fetchers sometimes return “An unknown error occurred.”
If fetch fails: keep the URL, retry once, or use search/`curl`. Never invent
platform-specific specs (point sizes, Liquid Glass rules) from stale memory when
the live page is reachable.

---

## With app-ship-kit

| Kit pipeline | Role of this skill |
|--------------|-------------------|
| **B. UI surface** | After DESIGN.md critique — resolve HIG page before polish |
| **E. Ship** | Icons, launch, a11y pages; design resources for store assets |

Install (same repo):

```bash
npx skills add jeremys26/app-ship-kit --skill apple-design -y
```

Conflict rule: project `DESIGN.md` wins on brand/color. HIG wins on platform
conventions (tabs, sheets, Dynamic Type, system materials).
