return {
  "folke/snacks.nvim",
  opts = {
    -- core UI
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      hidden = true, -- show dotfiles in file pickers
      ignored = true, -- show git-ignored files
      sources = {
        explorer = { hidden = true, ignored = true },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    -- extras
    animate = { enabled = true },
    bufdelete = { enabled = true },
    dim = { enabled = true },
    git = { enabled = true },
    gitbrowse = { enabled = true },
    lazygit = { enabled = true },
    scratch = { enabled = true },
    terminal = { enabled = true },
    toggle = { enabled = true },
    zen = { enabled = true },
    -- NOTE: `image` intentionally off — needs kitty graphics protocol,
    -- not available in this terminal over SSH.
  },
}
