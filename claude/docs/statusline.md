# Statusline (claude-code-statusline)

This page explains how to install the statusline on any machine. The statusline is the
bar at the bottom of Claude Code that shows your git branch, model, context use, cost
and more. It is made by [erwint/claude-code-statusline](https://github.com/erwint/claude-code-statusline),
and it was installed here as the plugin `cc-statusline` (version 0.6.12).

## Install

### Option 1: plugin (recommended)

If you ran `bootstrap.sh`, your `settings.json` already lists the plugin. Open Claude Code and run:

```
/plugin marketplace add erwint/claude-code-statusline
/plugin install cc-statusline@cc-statusline
```

Then restart Claude Code or run `/clear`. The plugin downloads the right program for your
computer on its own. If the bar does not appear, run `/cc-statusline:setup`.

### Option 2: install script (no plugin)

macOS or Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/erwint/claude-code-statusline/main/install.sh | bash
```

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/erwint/claude-code-statusline/main/install.ps1 | iex
```

The script puts the program at `~/.claude/bin/claude-code-statusline` and adds the
`statusLine` setting to `~/.claude/settings.json`.

## Required setting

`settings.json` must point at the program. This repo already has it:

```json
"statusLine": {
  "type": "command",
  "command": "~/.claude/bin/claude-code-statusline"
}
```

## Why the program is not in this repo

The program is a compiled file (about 5 MB) built for one type of computer. This
machine is Linux on ARM, and the same file will not run on a Mac or on Intel. The
installer picks the correct one for each machine, so reinstall it instead of copying it.

## Settings you can change

Set these as environment variables (for example in the `env` section of `settings.json`).

| Variable | Default | What it does |
|---|---|---|
| `CLAUDE_STATUS_DISPLAY_MODE` | `colors` | `colors`, `minimal` or `background` |
| `CLAUDE_STATUS_INFO_MODE` | `none` | Add labels: `none`, `emoji` or `text` |
| `CLAUDE_STATUS_AUTO_UPDATE` | `true` | Check for a new version once a day |
| `CLAUDE_STATUS_CACHE_TTL` | `300` | Seconds to keep usage numbers before refreshing |
| `CLAUDE_STATUS_DEBUG` | `false` | Write a log to `/tmp/claude-statusline.log` |

You can also hide parts of the bar (context, tools, agents, todos, duration, session cost,
effort, PR, worktree) with `CLAUDE_STATUS_<NAME>=false`. The full list is in the
[upstream README](https://github.com/erwint/claude-code-statusline#configuration).

## What it reads

It runs `git` in your project, reads usage logs in `~/.claude/projects/` to estimate
daily and weekly cost, and reads your plan from your Claude login. If your Claude Code is
older, it may ask Anthropic's usage API for rate limits. Auto-update downloads new
versions from GitHub.

## Turn it off

Remove the `statusLine` block from `settings.json`, or run `/plugin` and disable `cc-statusline`.

## Troubleshooting

- **Nothing appears:** restart Claude Code, then run `/cc-statusline:setup`.
- **"Permission denied":** run `chmod +x ~/.claude/bin/claude-code-statusline`.
- **Odd output or crash on a new machine:** the program was copied from another type of
  computer. Delete it and reinstall with Option 1 or 2.
- **Need details:** set `CLAUDE_STATUS_DEBUG=true` and read `/tmp/claude-statusline.log`.
