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

# herdr-plus go.mod uses a 3-part version (e.g. 1.26.2); Go < 1.21 can't parse it. Go >= 1.21 auto-fetches the pinned toolchain.
go_minor() { go version 2>/dev/null | sed -nE 's/.*go1\.([0-9]+).*/\1/p'; }
if [ "$(go_minor || true)" -lt 21 ] 2>/dev/null || ! command -v go >/dev/null 2>&1; then
  case "$(uname -m)" in x86_64) goarch=amd64 ;; aarch64|arm64) goarch=arm64 ;; *) echo "unsupported arch for Go install" >&2; exit 1 ;; esac
  ver="$(curl -fsS 'https://go.dev/VERSION?m=text' | head -1)"
  echo "Go missing or too old; installing $ver to ~/.local/go..."
  mkdir -p "$HOME/.local"
  rm -rf "$HOME/.local/go"
  curl -fsSL "https://go.dev/dl/$ver.linux-$goarch.tar.gz" | tar -C "$HOME/.local" -xz
  export PATH="$HOME/.local/go/bin:$PATH"
  echo "Add 'export PATH=\$HOME/.local/go/bin:\$PATH' to your shell profile."
fi

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
