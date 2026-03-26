#!/bin/bash
# build-skills.sh — Resolve SKILL.md.tmpl → SKILL.md for all skills
# Usage: bash bin/build-skills.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Read shared content
PREAMBLE=$(cat "$ROOT/_shared/preamble.md")

count=0
errors=0

for tmpl in "$ROOT"/*/SKILL.md.tmpl; do
  [ -f "$tmpl" ] || continue
  dir=$(dirname "$tmpl")
  skill_name=$(basename "$dir")

  # Read template
  content=$(cat "$tmpl")

  # Replace {{PREAMBLE}} placeholder
  content="${content//\{\{PREAMBLE\}\}/$PREAMBLE}"

  # Write generated SKILL.md
  printf '%s\n' "$content" > "$dir/SKILL.md"
  count=$((count + 1))
done

echo "Built $count skills"
[ $errors -gt 0 ] && echo "($errors errors)" && exit 1
exit 0
