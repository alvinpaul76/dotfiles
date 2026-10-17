# Claude Code dotfiles

My global Claude Code setup: settings, hooks and skills.

- `./bootstrap.sh` installs this setup on a new machine.
- `./sync.sh` copies this machine's live config into the repo before you commit.
- [docs/statusline.md](docs/statusline.md) explains how to install the statusline.

`settings.json` sets these environment variables under `env`:

- `DISABLE_TELEMETRY=1` turns off telemetry.
- `CLAUDE_CODE_NO_FLICKER=1` enables the flicker-free renderer.

After bootstrap, open Claude Code and run `/plugin` to install the plugins listed in
`settings.json`.
