#!/usr/bin/env bash
# Install this config on a new machine. Backs up anything it overwrites.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=../lib/deps.sh
. "$here/../lib/deps.sh"
ensure_cmd rsync
ts=$(date +%s)
mkdir -p ~/.claude ~/.agents
[ -f ~/.claude/settings.json ] && cp ~/.claude/settings.json ~/.claude/settings.json.bak-"$ts"
cp "$here/claude/settings.json" ~/.claude/settings.json
rsync -a "$here/claude/hooks/" ~/.claude/hooks/
for f in CLAUDE.md; do
  if [ -f "$here/claude/$f" ]; then cp "$here/claude/$f" ~/.claude/"$f"; fi
done
for d in agents commands; do
  if [ -d "$here/claude/$d" ]; then rsync -a "$here/claude/$d/" ~/.claude/"$d"/; fi
done
rsync -a "$here/agents/" ~/.agents/
# global skills are symlinks into ~/.agents/skills
mkdir -p ~/.claude/skills
for s in ~/.agents/skills/*/; do
  [ -d "$s" ] || continue # empty glob: nothing to link
  name="$(basename "$s")"
  ln -sfn "../../.agents/skills/$name" ~/.claude/skills/"$name"
done
echo "Done. Start 'claude' and run /plugin to install the plugins listed in settings.json (enabledPlugins)."
