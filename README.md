# App Ship Kit

Portable **Agent Skill** that teaches coding agents how to build and ship apps:
minimal diffs, layer discipline, UI critique→polish→copy, security/RLS, and
release gates.

Works with any product. Defaults assume **Expo / React Native + TypeScript + Supabase**
when those files are present; otherwise adapt to Next.js, Workers, etc.

Compatible with the [Agent Skills](https://agentskills.io) open standard.
Install via [`npx skills`](https://github.com/vercel-labs/skills) into Cursor, Claude Code,
Codex, and other agents.

---

## Quick start (new project)

From your **app repo root** (not this skills repo):

```bash
# 1. Install the skill into this project
npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y

# 2. Scaffold DESIGN.md + AGENTS.md + ship checklist (optional but recommended)
npx --yes skills add jeremys26/app-ship-kit --skill app-ship-kit -y   # if not already
# Or from a clone of this repo:
#   ./skills/app-ship-kit/scripts/setup.sh --init
```

If you cloned this repo:

```bash
cd /path/to/your-app
/path/to/app-ship-kit/skills/app-ship-kit/scripts/setup.sh --init
# optional depth:
/path/to/app-ship-kit/skills/app-ship-kit/scripts/setup.sh --stack expo-supabase
```

Then in Agent chat:

```text
use app-ship-kit — bootstrap this new project
```

Fill `.claude/DESIGN.md` (brand, tokens, do/don't). After that, say `use app-ship-kit`
for features, UI, security, review, or ship.

---

## Install only (existing project)

```bash
npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y
```

Optional upstream packs (still one command via setup):

| Stack | Purpose |
|-------|---------|
| `expo-supabase` | Expo + Supabase official skills |
| `expo-mobile` | Expo + Callstack RN perf |
| `ios-ship` | Expo + App Store preflight |
| `a11y` / `perf` / `security` | Focused packs |

```bash
./skills/app-ship-kit/scripts/setup.sh --stack expo-supabase
```

---

## What you get

| Pipeline | Use for |
|----------|---------|
| A Feature / fix | YAGNI ladder → smallest correct diff + one check |
| B UI | Design brief → critique → polish → de-slopify → verify |
| C Backend | Migrations, RLS, RPCs, edge patterns |
| D Pre-merge | Correctness → structure → deletion → security |
| E Ship | Store/web checklist + human device QA reminder |

Templates: design brief, ship checklist, AGENTS snippet.  
Depth on demand: `skills/app-ship-kit/references/` (progressive disclosure).

RN/iOS defaults without extra installs: [`mobile-ui.md`](skills/app-ship-kit/references/mobile-ui.md).  
Upstream catalog: [`ecosystem.md`](skills/app-ship-kit/references/ecosystem.md).

---

## Layout

```text
skills/app-ship-kit/
├── SKILL.md
├── references/
├── assets/
└── scripts/
    ├── setup.sh      # --init scaffolds project files; --stack adds upstream
    └── validate.sh
```

## License

MIT — see [LICENSE](LICENSE). Changelog: [CHANGELOG.md](CHANGELOG.md).
