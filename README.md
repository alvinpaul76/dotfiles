# Cre8or Lab dotfiles

Cre8or Lab dotfiles for a consistent setup on every machine.

## Contents

| Path                          | What it is                                                                                                                                      |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| [`claude/`](claude/README.md) | Global Claude Code setup: settings, hooks, agents and skills. Includes `bootstrap.sh` (install) and `sync.sh` (copy live config into the repo). |
| [`nvim/`](nvim/README.md)     | Neovim (LazyVim) config. Includes `bootstrap.sh` (install) and `sync.sh` (copy live config into the repo).                                      |

## Usage

```sh
git clone git@github.com:alvinpaul76/dotfiles.git ~/dotfiles
cd ~/dotfiles/claude && ./bootstrap.sh
cd ~/dotfiles/nvim && ./bootstrap.sh
```

See [`claude/README.md`](claude/README.md) for details, including the post-install `/plugin` step and [`nvim/README.md`](nvim/README.md) for the Neovim setup.
