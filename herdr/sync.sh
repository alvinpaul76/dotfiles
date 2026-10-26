#!/usr/bin/env bash
# Pull the live herdr config and plugin settings from this machine into the repo (run before committing).
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=../lib/deps.sh
. "$here/../lib/deps.sh"
ensure_cmd rsync
src="${XDG_CONFIG_HOME:-$HOME/.config}/herdr"
[ -f "$src/config.toml" ] && [ -d "$src/plugins/config" ] || { echo "no herdr config found in $src; nothing to sync." >&2; exit 1; }
cp "$src/config.toml" "$here/config.toml"
mkdir -p "$here/plugins/config"
rsync -a --delete "$src/plugins/config/" "$here/plugins/config/"
echo "synced -> $here"
