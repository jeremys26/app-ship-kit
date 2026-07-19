# Contributing

## Principles

- Keep `SKILL.md` under ~500 lines; put depth in `references/`.
- One pipeline job per reference file; don't merge UI + security into one blob.
- Prefer linking upstream skills in `ecosystem.md` over vendoring their text.
- Sibling skill **`apple-design`** may index Apple URLs and topics — never paste copyrighted HIG prose into the repo; link + fetch live.
- Descriptions are **trigger conditions**, not marketing copy.
- Paths use forward slashes (`scripts/setup.sh`).
- No product names, brands, or private app details in this repo — keep examples generic.

## Test a change

1. `./skills/app-ship-kit/scripts/validate.sh`
2. In a throwaway app: `scripts/setup.sh --init` from that app's root (pass the path to this repo's setup.sh).
3. Confirm `apple-design` landed under `.cursor/skills/apple-design` when installing from this repo.
4. In Agent chat: `use app-ship-kit` and run one pipeline (see `references/examples.md`).
5. Confirm the agent loads only the referenced file, not the whole tree.
6. Grep for accidental product names before release.

## Release

1. Push this repository root to GitHub.
2. Peers install: `npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y`
3. Optional HIG index: `npx skills add jeremys26/app-ship-kit --skill apple-design -y` (also installed by `setup.sh` from a clone of this repo)
4. Optional: list on [skills.sh](https://skills.sh).
