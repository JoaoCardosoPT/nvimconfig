return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "-" },
      changedelete = { text = "~" },
    },
    current_line_blame = false,
    on_attach = function(buf)
      local gs = require("gitsigns")
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
      end
      map("]c", function()
        if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
      end, "Next Git change")
      map("[c", function()
        if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
      end, "Previous Git change")
      map("<leader>hp", gs.preview_hunk, "Preview Git change")
      map("<leader>hs", gs.stage_hunk, "Stage/unstage Git change")
      map("<leader>hb", gs.blame_line, "Git blame for line")
      map("<leader>hd", gs.diffthis, "Diff against Git index")
    end,
  },
}
