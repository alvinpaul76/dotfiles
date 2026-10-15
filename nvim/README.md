# Neovim dotfiles

My LazyVim-based Neovim config (`~/.config/nvim`).

- `./bootstrap.sh` installs this config on a new machine (existing config is moved to `nvim.bak-<timestamp>`).
- `./sync.sh` copies this machine's live config into `config/` before you commit.

`lazy-lock.json` is included, so plugin versions stay the same on every machine.
Update plugins with `:Lazy update`, then run `./sync.sh` to capture the new lockfile.
