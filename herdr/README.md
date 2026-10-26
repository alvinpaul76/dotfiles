# herdr

[herdr](https://herdr.dev) config and plugins.

## Contents

| Path                   | What it is                                                              |
| ---------------------- | ----------------------------------------------------------------------- |
| `config.toml`          | herdr settings: theme, terminal behaviour, plugin keybindings.          |
| `plugins/config/`      | Per-plugin settings (herdr-plus projects and quick actions).            |
| `bootstrap.sh`         | Installs the config and both plugins on a new machine.                  |
| `sync.sh`              | Copies the live config from this machine into the repo.                 |

## Plugins

| Plugin                                                                         | Plugin ID              | Purpose                                                                 |
| ------------------------------------------------------------------------------ | ---------------------- | ----------------------------------------------------------------------- |
| [speardragon/herdr-plugin-manager](https://github.com/speardragon/herdr-plugin-manager) | `ray.plugin-manager`   | Popup to list, install, update, enable/disable and uninstall plugins.   |
| [cloudmanic/herdr-plus](https://github.com/cloudmanic/herdr-plus)              | `cloudmanic.herdr-plus` | Projects (workspace templates) and Quick Actions (one-off scripts).     |

## Install (bootstrap)

Requires `herdr` (>= 0.7.4) already installed.

```sh
cd ~/dotfiles/herdr && ./bootstrap.sh
```

Or as part of the whole repo: `./deploy.sh herdr` (also runs with no arguments, or `git pull-deploy herdr`).

The script is safe to re-run. It:

1. Copies `config.toml` to `~/.config/herdr/` (an existing, different file is saved as `config.toml.bak-<timestamp>`).
2. Installs the latest Go to `~/.local/go` if Go is missing or older than 1.21 (herdr-plus needs it; add `~/.local/go/bin` to your `PATH`).
3. Installs each plugin that is not already installed.
4. Copies `plugins/config/` into `~/.config/herdr/plugins/config/`.
5. Reloads the herdr server config if one is running.

## Install plugins manually

```sh
herdr plugin install speardragon/herdr-plugin-manager
herdr plugin install cloudmanic/herdr-plus
herdr plugin list
```

Add `--yes` to skip the confirmation prompt, or `--ref <ref>` to pin a branch, tag or commit. herdr-plus is built on install (`scripts/build.sh`), so it needs Go >= 1.21 (go.mod pins a newer toolchain, auto-fetched).

Update later with `herdr plugin update`.

## Keybindings

Defined in `config.toml` as `[[keys.command]]` entries with `type = "plugin_action"`.

| Key             | Action                                  |
| --------------- | --------------------------------------- |
| `prefix+P`      | Open the plugin manager                 |
| `prefix+up`     | herdr-plus: Projects                    |
| `prefix+down`   | herdr-plus: Quick Actions               |

## herdr-plus config

- Projects: `plugins/config/cloudmanic.herdr-plus/projects/*.toml`. Each file declares a workspace (name, `working_dir`, `[[tabs]]` with optional `command`).
- Quick actions: `plugins/config/cloudmanic.herdr-plus/quick-actions/*.toml`.

## Saving changes

After editing config or projects on a machine, run `./sync.sh` and commit.
