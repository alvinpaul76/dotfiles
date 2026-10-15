#!/usr/bin/env bash
# Pull the live Neovim config from this machine into the repo (run before committing).
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
mkdir -p "$here/config"
rsync -a --delete --exclude '.git' "$src/" "$here/config/"
echo "synced -> $here/config"
