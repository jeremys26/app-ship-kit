#!/usr/bin/env bash
# Validate app-ship-kit structure (agentskills-friendly).
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ERR=0

fail() { echo "FAIL: $*" >&2; ERR=1; }
ok() { echo "OK: $*"; }

[[ -f "$SKILL_DIR/SKILL.md" ]] || fail "missing SKILL.md"
ok "SKILL.md present"

# Frontmatter name must match folder
FOLDER="$(basename "$SKILL_DIR")"
if head -n 20 "$SKILL_DIR/SKILL.md" | grep -q "^name:[[:space:]]*${FOLDER}[[:space:]]*$"; then
  ok "name matches folder ($FOLDER)"
else
  fail "frontmatter name must equal folder name ($FOLDER)"
fi

if head -n 30 "$SKILL_DIR/SKILL.md" | grep -q "^description:"; then
  ok "description present"
else
  fail "missing description frontmatter"
fi

LINES=$(wc -l < "$SKILL_DIR/SKILL.md" | tr -d ' ')
if [[ "$LINES" -gt 500 ]]; then
  fail "SKILL.md is ${LINES} lines (keep under 500)"
else
  ok "SKILL.md length ${LINES} (<500)"
fi

REQUIRED_REFS=(
  philosophy.md architecture.md review.md ui.md mobile-ui.md security.md
  backend.md ship.md verify.md ecosystem.md examples.md testing.md bootstrap.md
)
for f in "${REQUIRED_REFS[@]}"; do
  [[ -f "$SKILL_DIR/references/$f" ]] || fail "missing references/$f"
done
ok "required references present"

REQUIRED_ASSETS=(design-brief-template.md AGENTS.snippet.md ship-checklist-template.md)
for f in "${REQUIRED_ASSETS[@]}"; do
  [[ -f "$SKILL_DIR/assets/$f" ]] || fail "missing assets/$f"
done
ok "required assets present"

[[ -x "$SKILL_DIR/scripts/setup.sh" ]] || fail "scripts/setup.sh not executable"
[[ -x "$SKILL_DIR/scripts/validate.sh" ]] || fail "scripts/validate.sh not executable"
ok "scripts executable"

# Broken relative links inside SKILL.md (simple check)
while IFS= read -r link; do
  target="$SKILL_DIR/$link"
  [[ -e "$target" ]] || fail "SKILL.md broken link: $link"
done < <(grep -oE '\[[^]]+\]\((references|assets|scripts)/[^)]+\)' "$SKILL_DIR/SKILL.md" \
  | sed -E 's/.*\(([^)]+)\).*/\1/' || true)
ok "SKILL.md relative links resolve"

# Sibling skill (same GitHub repo)
AD_DIR="$(cd "$SKILL_DIR/.." && pwd)/apple-design"
if [[ -d "$AD_DIR" ]]; then
  echo "==> Validating sibling apple-design"
  [[ -f "$AD_DIR/SKILL.md" ]] || fail "apple-design missing SKILL.md"
  if head -n 20 "$AD_DIR/SKILL.md" | grep -q '^name:[[:space:]]*apple-design[[:space:]]*$'; then
    ok "apple-design name matches folder"
  else
    fail "apple-design frontmatter name must be apple-design"
  fi
  AD_LINES=$(wc -l < "$AD_DIR/SKILL.md" | tr -d ' ')
  if [[ "$AD_LINES" -gt 500 ]]; then
    fail "apple-design SKILL.md is ${AD_LINES} lines (keep under 500)"
  else
    ok "apple-design SKILL.md length ${AD_LINES} (<500)"
  fi
  for f in index.md lookup.md hig-topics.md pathway.md resources.md; do
    [[ -f "$AD_DIR/references/$f" ]] || fail "apple-design missing references/$f"
  done
  ok "apple-design required references present"
  while IFS= read -r link; do
    target="$AD_DIR/$link"
    [[ -e "$target" ]] || fail "apple-design SKILL.md broken link: $link"
  done < <(grep -oE '\[[^]]+\]\((references|assets|scripts)/[^)]+\)' "$AD_DIR/SKILL.md" \
    | sed -E 's/.*\(([^)]+)\).*/\1/' || true)
  ok "apple-design relative links resolve"
fi

if [[ "$ERR" -ne 0 ]]; then
  echo "Validation failed." >&2
  exit 1
fi
echo "Validation passed."
