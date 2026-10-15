# Cre8or Lab dotfiles

Cre8or Lab dotfiles for a consistent setup on every machine.

## Contents

| Path                          | What it is                                                                                                                                      |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| [`claude/`](claude/README.md) | Global Claude Code setup: settings, hooks, agents and skills. Includes `bootstrap.sh` (install) and `sync.sh` (copy live config into the repo). |

## Usage

```sh
git clone git@github.com:alvinpaul76/dotfiles.git ~/dotfiles
cd ~/dotfiles/claude && ./bootstrap.sh
```

See [`claude/README.md`](claude/README.md) for details, including the post-install `/plugin` step.

## Related

- Neovim config (LazyVim) lives separately in `~/.config/nvim`.
