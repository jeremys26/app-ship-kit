# App Ship Kit

Portable **Agent Skill** that teaches coding agents how to build and ship apps:
minimal diffs, layer discipline, UI critique→polish→copy, RLS/security, and
release gates.

Distilled from shipping a production Expo + React Native + Supabase product.
**Product-agnostic** — no brand or domain lock-in.

Compatible with the [Agent Skills](https://agentskills.io) open standard and
installable via [`npx skills`](https://github.com/vercel-labs/skills) into
Cursor, Claude Code, Codex, and other agents.

## Install (peers — one command)

```bash
npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y
```

From a local checkout:

```bash
chmod +x skills/app-ship-kit/scripts/*.sh
./skills/app-ship-kit/scripts/setup.sh
./skills/app-ship-kit/scripts/validate.sh   # optional sanity check
```

Optional stack depth (still minimal):

```bash
./skills/app-ship-kit/scripts/setup.sh --stack expo-supabase   # Expo + Supabase
./skills/app-ship-kit/scripts/setup.sh --stack expo-mobile     # Expo + Callstack perf
./skills/app-ship-kit/scripts/setup.sh --stack ios-ship        # Expo + App Store preflight
./skills/app-ship-kit/scripts/setup.sh --stack a11y            # VoiceOver / Dynamic Type
./skills/app-ship-kit/scripts/setup.sh --stack perf            # Callstack only
./skills/app-ship-kit/scripts/setup.sh --stack security
```

Then in chat: **use app-ship-kit** (or `/app-ship-kit`).

## What you get

| Pipeline | Use for |
|----------|---------|
| A Feature / fix | YAGNI ladder → smallest correct diff + one check |
| B UI | Design brief → critique → polish → de-slopify → verify |
| C Backend | Migrations, RLS, RPCs, edge patterns |
| D Pre-merge | Correctness → structure → deletion → security |
| E Ship | Store/web checklist + human device QA reminder |

Also included: bootstrap checklist, examples, testing minimums, DESIGN/ship/AGENTS templates.

Details load on demand from `skills/app-ship-kit/references/` (progressive disclosure).

## Optional upstream skills (not vendored)

The kit **routes**; official packs go deep. See
[`skills/app-ship-kit/references/ecosystem.md`](skills/app-ship-kit/references/ecosystem.md).

| Pack | Command |
|------|---------|
| Expo (official — router, native UI, EAS) | `npx skills add expo/skills -y` |
| Supabase | `npx skills add supabase/agent-skills -y` |
| RN perf (Callstack) | `npx skills add callstackincubator/agent-skills --skill react-native-best-practices -y` |
| RN patterns (Vercel) | `npx skills add vercel-labs/agent-skills --skill vercel-react-native-skills -y` |
| iOS a11y (Axiom) | `npx skills add charleswiltgen/axiom --skill axiom-ios-accessibility -y` |
| App Store preflight | `npx skills add truongduy2611/app-store-preflight-skills -y` |
| Fail-open secrets | `npx skills add trailofbits/skills --skill insecure-defaults -y` |
| UI topic router | `npx ui-skills start` |

Full matrix + conflict rules: [`references/ecosystem.md`](skills/app-ship-kit/references/ecosystem.md). Portable RN defaults without installs: [`mobile-ui.md`](skills/app-ship-kit/references/mobile-ui.md).

## First session in a new app

1. `use app-ship-kit` → follow [bootstrap.md](skills/app-ship-kit/references/bootstrap.md)
2. Fill design brief → `.claude/DESIGN.md`
3. Optional: paste [AGENTS.snippet.md](skills/app-ship-kit/assets/AGENTS.snippet.md)
4. Name your stack once (Expo, Next, Workers…)

## Layout

```text
skills/app-ship-kit/
├── SKILL.md                 # Router (loaded on trigger)
├── references/              # Pipelines & checklists (on demand)
├── assets/                  # Templates (design, ship, AGENTS)
└── scripts/
    ├── setup.sh             # Local + optional stack install
    └── validate.sh          # Structure checks before publish
```

## Publish this repo

1. Push **this directory** as the GitHub repo root (not nested under another monorepo path).
2. Run `./skills/app-ship-kit/scripts/validate.sh`.
3. Optional: list on [skills.sh](https://skills.sh).

## Credits

Patterns inspired by practice shipping with Expo, Supabase, and community skills
(ponytail YAGNI ladder, UI critique/polish pipelines, Trail of Bits review habits).
Upstream skills are **linked**, not copied — see `ecosystem.md`.

## License

MIT — see [LICENSE](LICENSE). Changelog: [CHANGELOG.md](CHANGELOG.md).
