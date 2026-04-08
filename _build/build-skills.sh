#!/bin/bash
# build-skills.sh — Resolve SKILL.md.tmpl → SKILL.md for all skills
# Usage: bash _build/build-skills.sh

set -e

# Disable bash 5.2+ patsub_replacement so that '&' in replacement strings
# is treated literally (not as "the matched text"). Fallback silently on
# older bash versions that don't have this option.
shopt -u patsub_replacement 2>/dev/null || true

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Read shared content
PREAMBLE=$(cat "$SCRIPT_DIR/shared/preamble.md")
PROJECT_STATE=$(cat "$SCRIPT_DIR/shared/project-state.md")
VISUAL_STYLE_DEFAULT=$(cat "$SCRIPT_DIR/shared/visual-style-default.md")

count=0
errors=0

for tmpl in "$SCRIPT_DIR"/templates/*/SKILL.md.tmpl; do
  [ -f "$tmpl" ] || continue
  dir=$(basename "$(dirname "$tmpl")")

  # Read template
  content=$(cat "$tmpl")

  # Replace {{PREAMBLE}} placeholder
  content="${content//\{\{PREAMBLE\}\}/$PREAMBLE}"

  # Replace {{PROJECT_STATE}} placeholder (only present in project-aware skills)
  content="${content//\{\{PROJECT_STATE\}\}/$PROJECT_STATE}"

  # Replace {{VISUAL_STYLE_DEFAULT}} placeholder (used by setup-cs skill to seed brain)
  content="${content//\{\{VISUAL_STYLE_DEFAULT\}\}/$VISUAL_STYLE_DEFAULT}"

  # Write generated SKILL.md to skills/ directory
  mkdir -p "$ROOT/skills/$dir"
  printf '%s\n' "$content" > "$ROOT/skills/$dir/SKILL.md"

  # Mirror references/ directory if present (verbatim copy, no templating)
  tmpl_dir="$(dirname "$tmpl")"
  if [ -d "$tmpl_dir/references" ]; then
    rm -rf "$ROOT/skills/$dir/references"
    cp -R "$tmpl_dir/references" "$ROOT/skills/$dir/references"
  fi

  count=$((count + 1))
done

echo "Built $count skills → skills/**/SKILL.md"

[ $errors -gt 0 ] && echo "($errors errors)" && exit 1
exit 0
