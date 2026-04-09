#!/bin/bash
# check-brain.sh — SessionStart hook to check Brain status
# Install via ~/.claude/settings.json as a SessionStart hook pointing at this file.

BRAIN_DIR="$HOME/.creativestack"

if [ -d "$BRAIN_DIR" ]; then
  count=$(ls "$BRAIN_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
  echo "CREATIVESTACK BRAIN: $BRAIN_DIR ($count files)"
else
  echo "CREATIVESTACK BRAIN: not configured (run /setup-brain to set up)"
fi

# Self-locate the CreativeStack repo (the parent of scripts/)
STACK_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Check for updates
cd "$STACK_ROOT" 2>/dev/null || exit 0
git fetch --quiet origin main 2>/dev/null
LOCAL=$(git rev-parse HEAD 2>/dev/null)
REMOTE=$(git rev-parse origin/main 2>/dev/null)
if [ -n "$LOCAL" ] && [ -n "$REMOTE" ] && [ "$LOCAL" != "$REMOTE" ]; then
  echo "CREATIVESTACK UPDATE AVAILABLE: run 'git -C $STACK_ROOT pull' to update"
fi
