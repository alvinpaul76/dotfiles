#!/usr/bin/env bash
# Install this Neovim config on a new machine. Backs up any existing config.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
dest="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
if [ -e "$dest" ]; then
  mv "$dest" "$dest.bak-$(date +%s)"
fi
mkdir -p "$dest"
rsync -a "$here/config/" "$dest/"
echo "Done. Start 'nvim'; LazyVim will install plugins on first launch."
