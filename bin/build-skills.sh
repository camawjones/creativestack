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

# Install symlinks into ~/.claude/skills/ so Claude Code discovers them
SKILLS_DIR="$HOME/.claude/skills"
INSTALL_DIR="$SKILLS_DIR/creativestack"

if [ -d "$SKILLS_DIR" ]; then
  # Sync repo to installed copy
  if [ -d "$INSTALL_DIR" ]; then
    rsync -a --delete --exclude='.git' "$ROOT/" "$INSTALL_DIR/"
    echo "Updated installed copy at $INSTALL_DIR"
  else
    cp -R "$ROOT" "$INSTALL_DIR"
    rm -rf "$INSTALL_DIR/.git"
    echo "Installed copy to $INSTALL_DIR"
  fi

  # Create top-level symlinks for each skill
  linked=0
  for dir in "$INSTALL_DIR"/*/; do
    skill=$(basename "$dir")
    if [ -f "$dir/SKILL.md" ] && [ ! -e "$SKILLS_DIR/$skill" ]; then
      ln -s "creativestack/$skill" "$SKILLS_DIR/$skill"
      linked=$((linked + 1))
    fi
  done
  [ $linked -gt 0 ] && echo "Created $linked new skill symlinks"
fi

[ $errors -gt 0 ] && echo "($errors errors)" && exit 1
exit 0
