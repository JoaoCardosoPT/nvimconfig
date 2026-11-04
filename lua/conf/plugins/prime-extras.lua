-- Remaining plugins in ThePrimeagen/neovimrc, using public repositories.
return {
  { "github/copilot.vim", cmd = "Copilot", event = "InsertEnter" },
  { "hrsh7th/cmp-cmdline", dependencies = { "hrsh7th/nvim-cmp" } },
  {
    "danymat/neogen", dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
    opts = { snippet_engine = "luasnip" },
    keys = {
      { "<leader>nf", function() require("neogen").generate({ type = "func" }) end, desc = "Document function" },
      { "<leader>nt", function() require("neogen").generate({ type = "type" }) end, desc = "Document type" },
    },
  },
  -- Neovim already includes EditorConfig and the CursorHold fix upstream needed.
}
