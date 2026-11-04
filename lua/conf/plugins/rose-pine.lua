return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  opts = {
    variant = "main",
    styles = { italic = true, transparency = true },
    highlight_groups = {
      Cursor = { fg = "base", bg = "text" },
    },
  },
}
