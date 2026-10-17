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

## Updating a host

On each host you want to keep in sync, run `git pull-deploy` from inside the repo. It runs `git pull --ff-only`, then both `bootstrap.sh` scripts, all on that host.

The alias is per-repo and is created by `deploy.sh`, so run it once after cloning:

```sh
cd ~/dotfiles && ./deploy.sh   # first time: registers the alias and deploys
git pull-deploy                # afterwards, on that host
```

To deploy only some components, name them:

```sh
git pull-deploy claude        # Claude Code setup only
git pull-deploy nvim          # Neovim only
git pull-deploy claude nvim   # both (same as no arguments)
```

The pull is fast-forward only, so it fails instead of merging if the host has local commits.
