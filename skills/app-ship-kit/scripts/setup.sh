#!/usr/bin/env bash
# Install app-ship-kit into a project (+ optional scaffold / stack packs).
set -euo pipefail

STACK=""
GLOBAL=0
INIT=0
AGENT_ARGS=()

usage() {
  cat <<'EOF'
Usage: setup.sh [options]

Run from your app's repository root.

Options:
  --init              Scaffold .claude/DESIGN.md, AGENTS.md, docs/ship-checklist.md
                      (skips files that already exist)
  --stack <name>      Install curated upstream skills (needs network + npx)
  --global, -g        Install skill to user dirs instead of this project
  --agent <name>      Pass through to npx skills (repeatable)
  -h, --help          Show help

Stacks: expo-supabase | expo-mobile | ios-ship | expo | supabase | perf | a11y | security

Examples (from your app root):
  path/to/app-ship-kit/skills/app-ship-kit/scripts/setup.sh --init
  path/to/app-ship-kit/skills/app-ship-kit/scripts/setup.sh --init --stack expo-supabase
  npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y   # install only
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --init) INIT=1; shift ;;
    --stack) STACK="${2:-}"; shift 2 ;;
    --global|-g) GLOBAL=1; shift ;;
    --agent|-a) AGENT_ARGS+=(--agent "$2"); shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

SKILL_SRC="$(cd "$(dirname "$0")/.." && pwd)"
ASSETS="$SKILL_SRC/assets"
PROJECT="$(pwd)"

skills_add() {
  local extra=()
  (( GLOBAL )) && extra+=(-g)
  npx --yes skills add "$@" "${extra[@]}" "${AGENT_ARGS[@]}" -y 2>/dev/null \
    || npx --yes skills add "$@" "${extra[@]}" "${AGENT_ARGS[@]}"
}

install_local_copy() {
  local dest_base dest
  if (( GLOBAL )); then
    dest_base="${HOME}/.cursor/skills"
  else
    dest_base="${PROJECT}/.cursor/skills"
  fi
  mkdir -p "$dest_base"
  dest="${dest_base}/app-ship-kit"
  rm -rf "$dest"
  cp -R "$SKILL_SRC" "$dest"
  if (( ! GLOBAL )); then
    mkdir -p "${PROJECT}/.claude/skills" "${PROJECT}/.agents/skills"
    rm -rf "${PROJECT}/.claude/skills/app-ship-kit" "${PROJECT}/.agents/skills/app-ship-kit"
    cp -R "$SKILL_SRC" "${PROJECT}/.claude/skills/app-ship-kit"
    cp -R "$SKILL_SRC" "${PROJECT}/.agents/skills/app-ship-kit"
  else
    mkdir -p "${HOME}/.claude/skills" "${HOME}/.agents/skills"
    rm -rf "${HOME}/.claude/skills/app-ship-kit" "${HOME}/.agents/skills/app-ship-kit"
    cp -R "$SKILL_SRC" "${HOME}/.claude/skills/app-ship-kit"
    cp -R "$SKILL_SRC" "${HOME}/.agents/skills/app-ship-kit"
  fi
  echo "Installed app-ship-kit → ${dest}"
}

scaffold_project() {
  mkdir -p "${PROJECT}/.claude" "${PROJECT}/docs"

  if [[ ! -f "${PROJECT}/.claude/DESIGN.md" && ! -f "${PROJECT}/DESIGN.md" ]]; then
    cp "$ASSETS/design-brief-template.md" "${PROJECT}/.claude/DESIGN.md"
    echo "Created .claude/DESIGN.md — fill brand/tokens before UI work"
  else
    echo "Skip DESIGN.md (already present)"
  fi

  if [[ ! -f "${PROJECT}/docs/ship-checklist.md" ]]; then
    cp "$ASSETS/ship-checklist-template.md" "${PROJECT}/docs/ship-checklist.md"
    echo "Created docs/ship-checklist.md"
  else
    echo "Skip docs/ship-checklist.md (already present)"
  fi

  local snippet
  # Prefer fenced markdown body; fall back to whole file minus the title line
  if grep -q '^```markdown$' "$ASSETS/AGENTS.snippet.md"; then
    snippet="$(sed -n '/^```markdown$/,/^```$/p' "$ASSETS/AGENTS.snippet.md" | sed '1d;$d')"
  else
    snippet="$(tail -n +3 "$ASSETS/AGENTS.snippet.md")"
  fi

  if [[ ! -f "${PROJECT}/AGENTS.md" ]]; then
    {
      echo "# Agent notes"
      echo
      echo "$snippet"
    } > "${PROJECT}/AGENTS.md"
    echo "Created AGENTS.md"
  elif ! grep -q 'app-ship-kit' "${PROJECT}/AGENTS.md" 2>/dev/null; then
    {
      echo
      echo "$snippet"
    } >> "${PROJECT}/AGENTS.md"
    echo "Appended app-ship-kit block to AGENTS.md"
  else
    echo "Skip AGENTS.md (app-ship-kit already mentioned)"
  fi

  if [[ -f "${PROJECT}/CLAUDE.md" ]] && ! grep -q 'app-ship-kit' "${PROJECT}/CLAUDE.md" 2>/dev/null; then
    {
      echo
      echo "$snippet"
    } >> "${PROJECT}/CLAUDE.md"
    echo "Appended app-ship-kit block to CLAUDE.md"
  fi
}

echo "==> Installing app-ship-kit into: ${PROJECT}"
install_local_copy

if (( INIT )); then
  echo "==> Scaffolding project files (--init)"
  scaffold_project
fi

if [[ -z "$STACK" ]]; then
  echo "==> Done."
  if (( INIT )); then
    echo "    Next: edit .claude/DESIGN.md, then in chat: use app-ship-kit"
  else
    echo "    Optional: re-run with --init and/or --stack expo-supabase"
    echo "    In chat: use app-ship-kit"
  fi
  exit 0
fi

if ! command -v npx >/dev/null 2>&1; then
  echo "npx not found; skip stack packs. Install Node, then re-run with --stack." >&2
  exit 0
fi

echo "==> Installing stack pack: ${STACK}"
case "$STACK" in
  expo-supabase)
    skills_add expo/skills
    skills_add supabase/agent-skills
    ;;
  expo-mobile)
    skills_add expo/skills
    skills_add callstackincubator/agent-skills --skill react-native-best-practices
    ;;
  ios-ship)
    skills_add expo/skills
    skills_add truongduy2611/app-store-preflight-skills
    ;;
  expo)
    skills_add expo/skills
    ;;
  supabase)
    skills_add supabase/agent-skills
    ;;
  perf)
    skills_add callstackincubator/agent-skills --skill react-native-best-practices
    ;;
  a11y)
    skills_add charleswiltgen/axiom --skill axiom-ios-accessibility
    ;;
  security)
    skills_add trailofbits/skills --skill insecure-defaults --skill differential-review
    ;;
  *)
    echo "Unknown stack: $STACK" >&2
    echo "Expected: expo-supabase|expo-mobile|ios-ship|expo|supabase|perf|a11y|security" >&2
    exit 1
    ;;
esac

echo "==> Done. In chat: use app-ship-kit"
echo "    Upstream depth: see references/ecosystem.md (inside the installed skill)"
