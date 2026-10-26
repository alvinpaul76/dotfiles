#!/usr/bin/env bash
# Install herdr config and plugins on a new machine. Idempotent; backs up a differing config.toml.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=../lib/deps.sh
. "$here/../lib/deps.sh"
ensure_cmd rsync
command -v herdr >/dev/null 2>&1 || { echo "herdr not found; install it first (https://herdr.dev)." >&2; exit 1; }

dest="${XDG_CONFIG_HOME:-$HOME/.config}/herdr"
mkdir -p "$dest"

if [ -e "$dest/config.toml" ] && ! cmp -s "$here/config.toml" "$dest/config.toml"; then
  cp "$dest/config.toml" "$dest/config.toml.bak-$(date +%s)"
fi
cp "$here/config.toml" "$dest/config.toml"

command -v go >/dev/null 2>&1 || { echo "go not found; herdr-plus is built on install and needs the Go toolchain." >&2; exit 1; }

plugins=(speardragon/herdr-plugin-manager cloudmanic/herdr-plus)
installed="$(herdr plugin list)"
for p in "${plugins[@]}"; do
  if [[ "$installed" == *"github:$p@"* ]]; then
    echo "plugin $p already installed"
  else
    herdr plugin install --yes "$p"
  fi
done

mkdir -p "$dest/plugins/config"
rsync -a "$here/plugins/config/" "$dest/plugins/config/"

herdr server reload-config >/dev/null 2>&1 || true
echo "Done. herdr config and plugins installed."
