#!/usr/bin/env bash
# Install app-ship-kit into a project (+ optional scaffold / stack packs).
#
# Safe to run from inside an already-installed skill path (e.g.
# .cursor/skills/app-ship-kit/scripts/setup.sh). Copies via a temp staging
# dir first so we never delete the script's own source mid-run.
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

Typical flow (from your app root):
  npx skills add jeremys26/app-ship-kit --skill app-ship-kit -y
  .cursor/skills/app-ship-kit/scripts/setup.sh --init --stack expo-supabase

Or from a separate clone of this repo:
  /path/to/app-ship-kit/skills/app-ship-kit/scripts/setup.sh --init --stack expo-supabase
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

# Original location (may be inside the project skill dir we are about to refresh)
SKILL_SRC="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$(pwd)"

# Stage immediately so later rm -rf of install targets cannot delete our source
STAGE="$(mktemp -d "${TMPDIR:-/tmp}/app-ship-kit.XXXXXX")"
cleanup() { rm -rf "$STAGE"; }
trap cleanup EXIT

cp -R "$SKILL_SRC" "$STAGE/app-ship-kit"
WORK_SRC="$STAGE/app-ship-kit"
ASSETS="$WORK_SRC/assets"

realpath_safe() {
  local p="$1"
  if [[ -d "$p" ]]; then (cd "$p" && pwd -P)
  elif [[ -e "$p" ]]; then
    local d; d="$(cd "$(dirname "$p")" && pwd -P)"
    echo "$d/$(basename "$p")"
  else
    echo "$p"
  fi
}

same_path() {
  [[ "$(realpath_safe "$1")" == "$(realpath_safe "$2")" ]]
}

skills_add() {
  local extra=()
  (( GLOBAL )) && extra+=(-g)
  npx --yes skills add "$@" "${extra[@]}" "${AGENT_ARGS[@]}" -y 2>/dev/null \
    || npx --yes skills add "$@" "${extra[@]}" "${AGENT_ARGS[@]}"
}

# Copy staged skill into dest. Never rm dest if it is the live WORK_SRC (impossible
# after staging) — but do skip no-op when dest already equals a path we just wrote.
install_one() {
  local dest="$1"
  mkdir -p "$(dirname "$dest")"
  if [[ -d "$dest" ]] && same_path "$dest" "$WORK_SRC"; then
    echo "Skip $dest (same as staging — should not happen)"
    return
  fi
  rm -rf "$dest"
  cp -R "$WORK_SRC" "$dest"
  echo "Installed → $dest"
}

install_local_copy() {
  if (( GLOBAL )); then
    install_one "${HOME}/.cursor/skills/app-ship-kit"
    install_one "${HOME}/.claude/skills/app-ship-kit"
    install_one "${HOME}/.agents/skills/app-ship-kit"
  else
    install_one "${PROJECT}/.cursor/skills/app-ship-kit"
    install_one "${PROJECT}/.claude/skills/app-ship-kit"
    install_one "${PROJECT}/.agents/skills/app-ship-kit"
  fi
}

# Sibling skill shipped in the same GitHub repo (optional; skip if absent).
install_apple_design_sibling() {
  local sibling_src
  sibling_src="$(cd "$SKILL_SRC/.." && pwd)/apple-design"
  [[ -f "$sibling_src/SKILL.md" ]] || return 0

  local stage_ad
  stage_ad="$(mktemp -d "${TMPDIR:-/tmp}/apple-design.XXXXXX")"
  cp -R "$sibling_src" "$stage_ad/apple-design"

  install_ad() {
    local dest="$1"
    mkdir -p "$(dirname "$dest")"
    rm -rf "$dest"
    cp -R "$stage_ad/apple-design" "$dest"
    echo "Installed → $dest"
  }

  if (( GLOBAL )); then
    install_ad "${HOME}/.cursor/skills/apple-design"
    install_ad "${HOME}/.claude/skills/apple-design"
    install_ad "${HOME}/.agents/skills/apple-design"
  else
    install_ad "${PROJECT}/.cursor/skills/apple-design"
    install_ad "${PROJECT}/.claude/skills/apple-design"
    install_ad "${PROJECT}/.agents/skills/apple-design"
  fi
  rm -rf "$stage_ad"
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
echo "    (staged from ${SKILL_SRC})"
install_local_copy
echo "==> Installing sibling apple-design (if present in repo)"
install_apple_design_sibling

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
