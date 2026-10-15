#!/usr/bin/env bash
# Pull live config from this machine into the repo (run before committing).
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$here/claude" "$here/agents"
cp ~/.claude/settings.json "$here/claude/settings.json"
rsync -a --delete ~/.claude/hooks/ "$here/claude/hooks/"
for f in CLAUDE.md; do [ -f ~/.claude/$f ] && cp ~/.claude/$f "$here/claude/$f" || true; done
for d in agents commands; do [ -d ~/.claude/$d ] && rsync -a --delete ~/.claude/$d/ "$here/claude/$d/" || true; done
rsync -a --delete ~/.agents/ "$here/agents/"
echo "synced -> $here"
