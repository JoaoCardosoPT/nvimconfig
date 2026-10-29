-- Screenshot-inspired palette; retain the existing background and opacity.
return {
  "oskarnurm/koda.nvim",
  enabled = false, -- The classic UI uses the bundled Vim colors.
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.background = "dark"
    require("koda").setup({
      colors = {
        bg = "#090909",
        line = "#1a1a1a",
        fg = "#e0def4",
        dim = "#6e6a86",
        comment = "#6e6a86",
        keyword = "#31748f",
        type = "#9ccfd8",
        operator = "#908caa",
        func = "#ebbcba",
        string = "#f6c177",
        char = "#f6c177",
        const = "#f6c177",
        special = "#e0def4",
        emphasis = "#c4a7e7",
        highlight = "#31748f",
        info = "#9ccfd8",
        success = "#9ccfd8",
        warning = "#f6c177",
        danger = "#eb6f92",
      },
      styles = { functions = { bold = false } },
      on_highlights = function(hl, c)
        hl.Boolean = { fg = "#ebbcba" }
        hl.Delimiter = { fg = "#908caa" }
        hl["@keyword.return"] = { link = "Keyword" }
        hl["@punctuation.bracket"] = { link = "Delimiter" }
        hl["@punctuation.special"] = { link = "Delimiter" }
        hl["@variable.parameter"] = { fg = "#c4a7e7" }
        hl["@lsp.type.parameter"] = { link = "@variable.parameter" }
        hl.Type = { fg = c.type, bold = true }
        hl.Cursor = { fg = c.bg, bg = c.fg }
        hl.StatusLine = { fg = "#908caa", bg = "#26233a" }
        hl.StatusLineNC = { fg = "#6e6a86", bg = "#191724" }
        hl.ModeMsg = { fg = "#908caa" }
        hl.WinSeparator = { fg = "#26233a", bg = c.bg }
        hl.TabLine = { fg = "#6e6a86", bg = c.bg }
        hl.TabLineSel = { fg = c.fg, bg = "#26233a" }
        hl.TabLineFill = { bg = c.bg }
        hl.LineNr = { fg = "#6e6a86" }
        hl.CursorLineNr = { fg = "#908caa" }
      end,
    })
    vim.cmd.colorscheme("koda")
  end,
}
