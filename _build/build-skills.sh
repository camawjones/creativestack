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

# All known skill names for namespace rewriting
SKILLS=(
  ai-audit asset-spec brand-guidelines brief-sharpener case-study
  competitor-audit copy-deck creative-brief creative-strategy design-research
  feedback-consolidator job-description meeting-notes pitch-research post-mortem
  project-kickoff project-profitability proposal-generator resource-conflict
  rfi-response setup social-calendar source-scrape sow-generator
  status-update timeline-generator timesheet-summary trend-report update-voice
)

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

  # Replace {{VISUAL_STYLE_DEFAULT}} placeholder (used by setup skill to seed brain)
  content="${content//\{\{VISUAL_STYLE_DEFAULT\}\}/$VISUAL_STYLE_DEFAULT}"

  # Namespace rewriting: replace bare /skill-name references with /creativestack:skill-name
  # Handles backtick-wrapped references like `/skill-name`
  for skill in "${SKILLS[@]}"; do
    # Replace `/skill-name...` with `/creativestack:skill-name...` inside backticks
    # Handles: `/skill-name`, `/skill-name {arg}`, `/skill-name` at end of backtick
    content=$(echo "$content" | sed "s|\`/${skill} |\`/creativestack:${skill} |g")
    content=$(echo "$content" | sed "s|\`/${skill}\`|\`/creativestack:${skill}\`|g")
    # Replace bare /skill-name at word boundaries (in prose, not already namespaced)
    content=$(echo "$content" | sed "s| /${skill}| /creativestack:${skill}|g")
  done

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
