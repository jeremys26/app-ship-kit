# Contributing

## Principles

- Keep `SKILL.md` under ~500 lines; put depth in `references/`.
- One pipeline job per reference file; don't merge UI + security into one blob.
- Prefer linking upstream skills in `ecosystem.md` over vendoring their text.
- Descriptions are **trigger conditions**, not marketing copy.
- Paths use forward slashes (`scripts/setup.sh`).

## Test a change

1. `./skills/app-ship-kit/scripts/validate.sh`
2. Copy or symlink `skills/app-ship-kit` into a sample app's `.cursor/skills/`.
3. In Agent chat: `use app-ship-kit` and run one pipeline (see `references/examples.md`).
4. Confirm the agent loads only the referenced file, not the whole tree.

## Release as a public repo

1. Push this directory (`portable-skills/app-ship-kit` contents) as the repo root.
2. Peers install: `npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y`
3. Submit to [skills.sh](https://skills.sh) when ready for discovery.
