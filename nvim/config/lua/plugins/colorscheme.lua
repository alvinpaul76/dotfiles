return {
  -- add dracula
  {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    opts = {},
  },

  -- Configure LazyVim to load dracula
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
