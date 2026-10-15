#!/usr/bin/env bash
# Pull live config from this machine into the repo (run before committing).
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=../lib/deps.sh
. "$here/../lib/deps.sh"
ensure_cmd rsync
mkdir -p "$here/claude" "$here/agents"
cp ~/.claude/settings.json "$here/claude/settings.json"
rsync -a --delete ~/.claude/hooks/ "$here/claude/hooks/"
for f in CLAUDE.md; do
  if [ -f ~/.claude/"$f" ]; then cp ~/.claude/"$f" "$here/claude/$f"; fi
done
for d in agents commands; do
  if [ -d ~/.claude/"$d" ]; then rsync -a --delete ~/.claude/"$d"/ "$here/claude/$d/"; fi
done
rsync -a --delete ~/.agents/ "$here/agents/"
echo "synced -> $here"
