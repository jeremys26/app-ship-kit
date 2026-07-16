#!/usr/bin/env bash
# Minimal peer setup for app-ship-kit (+ optional stack packs).
set -euo pipefail

STACK=""
GLOBAL=0
AGENT_ARGS=()

usage() {
  cat <<'EOF'
Usage: setup.sh [--stack <name>] [--global] [--agent <name>...]

Stacks:
  expo-supabase   Expo skills + Supabase (default recommendation)
  expo-mobile     Expo skills + Callstack RN perf
  ios-ship        Expo skills + App Store preflight
  expo | supabase | perf | security | a11y

Examples:
  ./setup.sh
  ./setup.sh --stack expo-supabase
  ./setup.sh --stack expo-mobile
  ./setup.sh --stack ios-ship
  ./setup.sh --stack security --global
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --stack) STACK="${2:-}"; shift 2 ;;
    --global|-g) GLOBAL=1; shift ;;
    --agent|-a) AGENT_ARGS+=(--agent "$2"); shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
SKILL_SRC="$(cd "$(dirname "$0")/.." && pwd)"

skills_add() {
  local extra=()
  (( GLOBAL )) && extra+=(-g)
  # -y skips prompts when supported
  npx --yes skills add "$@" "${extra[@]}" "${AGENT_ARGS[@]}" -y 2>/dev/null \
    || npx --yes skills add "$@" "${extra[@]}" "${AGENT_ARGS[@]}"
}

install_local_copy() {
  local dest_base dest
  if (( GLOBAL )); then
    dest_base="${HOME}/.cursor/skills"
  else
    dest_base="$(pwd)/.cursor/skills"
  fi
  mkdir -p "$dest_base"
  dest="${dest_base}/app-ship-kit"
  rm -rf "$dest"
  cp -R "$SKILL_SRC" "$dest"
  # Claude / agents compatibility copies
  if (( ! GLOBAL )); then
    mkdir -p "$(pwd)/.claude/skills" "$(pwd)/.agents/skills"
    rm -rf "$(pwd)/.claude/skills/app-ship-kit" "$(pwd)/.agents/skills/app-ship-kit"
    cp -R "$SKILL_SRC" "$(pwd)/.claude/skills/app-ship-kit"
    cp -R "$SKILL_SRC" "$(pwd)/.agents/skills/app-ship-kit"
  else
    mkdir -p "${HOME}/.claude/skills" "${HOME}/.agents/skills"
    rm -rf "${HOME}/.claude/skills/app-ship-kit" "${HOME}/.agents/skills/app-ship-kit"
    cp -R "$SKILL_SRC" "${HOME}/.claude/skills/app-ship-kit"
    cp -R "$SKILL_SRC" "${HOME}/.agents/skills/app-ship-kit"
  fi
  echo "Installed app-ship-kit → ${dest}"
}

echo "==> Installing app-ship-kit (local copy)"
install_local_copy

if [[ -z "$STACK" ]]; then
  echo "==> Done (kit only). Optional stacks: expo-supabase | expo-mobile | ios-ship | perf | a11y"
  echo "    Say in chat: use app-ship-kit"
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
echo "    Upstream depth: see references/ecosystem.md (from skill root)"
