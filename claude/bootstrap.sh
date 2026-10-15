#!/usr/bin/env bash
# Install this config on a new machine. Backs up anything it overwrites.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
ts=$(date +%s)
mkdir -p ~/.claude ~/.agents
[ -f ~/.claude/settings.json ] && cp ~/.claude/settings.json ~/.claude/settings.json.bak-$ts
cp "$here/claude/settings.json" ~/.claude/settings.json
rsync -a "$here/claude/hooks/" ~/.claude/hooks/
for f in CLAUDE.md; do [ -f "$here/claude/$f" ] && cp "$here/claude/$f" ~/.claude/$f || true; done
for d in agents commands; do [ -d "$here/claude/$d" ] && rsync -a "$here/claude/$d/" ~/.claude/$d/ || true; done
rsync -a "$here/agents/" ~/.agents/
# global skills are symlinks into ~/.agents/skills
mkdir -p ~/.claude/skills
for s in ~/.agents/skills/*/; do ln -sfn "../../.agents/skills/$(basename "$s")" ~/.claude/skills/$(basename "$s"); done
echo "Done. Start 'claude' and run /plugin to install the plugins listed in settings.json (enabledPlugins)."
