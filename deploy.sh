#!/usr/bin/env bash
# Pull the latest dotfiles and deploy them on this machine.
# Usage: git pull-deploy [claude] [nvim]   (or ./deploy.sh ...)
# With no arguments, every component is deployed.
# The first run also registers the `pull-deploy` git alias for this repo.
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "$root"

components=(claude nvim)
targets=("$@")
(( ${#targets[@]} )) || targets=("${components[@]}")

for t in "${targets[@]}"; do
  [[ " ${components[*]} " == *" $t "* ]] || { echo "unknown component: $t (choose from: ${components[*]})" >&2; exit 2; }
done

git config alias.pull-deploy '!./deploy.sh'

git pull --ff-only
for t in "${targets[@]}"; do
  (cd "$t" && ./bootstrap.sh)
done
