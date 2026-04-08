#!/bin/bash
# check-vault.sh — SessionStart hook to check Brain status

BRAIN_DIR="$HOME/.creativestack"

if [ -d "$BRAIN_DIR" ]; then
  count=$(ls "$BRAIN_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
  echo "CREATIVESTACK BRAIN: $BRAIN_DIR ($count files)"
else
  echo "CREATIVESTACK BRAIN: not configured (run /creativestack:setup to set up)"
fi

# Check for updates
cd "$CLAUDE_PLUGIN_ROOT" 2>/dev/null
git fetch --quiet origin main 2>/dev/null
LOCAL=$(git rev-parse HEAD 2>/dev/null)
REMOTE=$(git rev-parse origin/main 2>/dev/null)
if [ -n "$LOCAL" ] && [ -n "$REMOTE" ] && [ "$LOCAL" != "$REMOTE" ]; then
  echo "CREATIVESTACK UPDATE AVAILABLE: run 'git -C $CLAUDE_PLUGIN_ROOT pull' to update"
fi
