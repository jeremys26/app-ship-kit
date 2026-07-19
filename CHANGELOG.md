# Changelog

## 0.4.0

- New sibling skill **`apple-design`**: index of [Apple Design](https://developer.apple.com/design/) (Overview, What’s New, Get Started, HIG, Resources) with intent→HIG URL lookup
- `setup.sh` installs `apple-design` alongside the kit when present in this repo
- Wired into pipeline B, `ui.md`, and `ecosystem.md` (HIG / Liquid Glass / SF Symbols / kits)

## 0.3.3

- `mobile-ui.md`: note that Reanimated 4 needs `react-native-worklets` as an explicit dep plus a `babel.config.js` (`babel-preset-expo`) — missing either fails silently in Metro rather than at install

## 0.3.2

- Fix `setup.sh` self-delete when run from `.cursor/skills/app-ship-kit` (stage to temp before install)
- Document in-app path: `.cursor/skills/app-ship-kit/scripts/setup.sh --init --stack …`

## 0.3.1

- Scrubbed product-specific names; generic examples only
- `setup.sh --init` scaffolds DESIGN.md, AGENTS.md, ship checklist for new apps
- README quick-start rewritten for greenfield projects

## 0.3.0

- Researched & curated RN/iOS/UI upstream skills into `ecosystem.md`
- Added `references/mobile-ui.md` — portable RN/iOS UI defaults without requiring installs
- New setup stacks: `expo-mobile`, `ios-ship`, `perf`, `a11y`
- Wired mobile-ui into UI/ship/verify pipelines

## 0.2.0

- Agentskills layout: `skills/app-ship-kit/{SKILL.md,references,assets,scripts}`
- `references/ecosystem.md` — curated upstream skills
- `scripts/setup.sh` — local install + optional `--stack` packs
- `scripts/validate.sh` — structure + link checks
- Added `examples`, `testing`, `bootstrap` references
- Assets: design brief, AGENTS snippet, ship checklist template
- Public-repo files: README, LICENSE, CONTRIBUTING, CHANGELOG

## 0.1.0

- Initial portable kit for Expo / RN / Supabase-style apps
- Pipelines A–E, philosophy / architecture / UI / security / backend / ship / verify
