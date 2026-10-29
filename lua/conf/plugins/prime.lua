-- Public Primeagen workflow plugins, adapted to this machine and current APIs.
return {
  {
    "ThePrimeagen/harpoon", branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon: add file" },
      { "<leader>A", function() require("harpoon"):list():prepend() end, desc = "Harpoon: prepend file" },
      { "<C-e>", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon menu" },
      { "<M-1>", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
      { "<M-2>", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
      { "<M-3>", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
      { "<M-4>", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
    },
  },
  {
    "tpope/vim-fugitive", cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit" },
    keys = { { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" } },
  },
  {
    "mbbill/undotree", cmd = "UndotreeToggle",
    keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo history" } },
  },
  {
    "folke/trouble.nvim", cmd = "Trouble", opts = { icons = false, focus = true },
    keys = {
      { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble diagnostics" },
      { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble quickfix" },
      { "]t", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next Trouble item" },
      { "[t", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Previous Trouble item" },
    },
  },
  {
    "folke/zen-mode.nvim", cmd = "ZenMode",
    opts = { window = { width = 90, options = { number = true, relativenumber = true } }, plugins = { kitty = { enabled = false } } },
    keys = { { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen mode" } },
  },
  {
    "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").filetype_extend("javascript", { "jsdoc" })
    end,
  },
  { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
  {
    "laytan/cloak.nvim", event = { "BufReadPre", "BufNewFile" },
    opts = {
      cloak_character = "*", highlight_group = "Comment",
      patterns = { { file_pattern = { ".env*", "wrangler.toml", ".dev.vars" }, cloak_pattern = "=.+" } },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects", branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })
      for lhs, query in pairs({ af = "@function.outer", ["if"] = "@function.inner", ac = "@class.outer", ic = "@class.inner" }) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
        end, { desc = "Select " .. query })
      end
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    commit = "8bcf893eb3871bc87b42adffe2fb9b0b7dc9d328", -- compatible with Neovim 0.12.4
    dependencies = { "lewis6991/async.nvim", "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = {},
    keys = { { "<leader>rr", function() require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "Refactor" } },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F8>", function() require("dap").continue() end, desc = "Debug: continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Debug: step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Debug: step into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Debug: step out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: breakpoint" },
    },
  },
  {
    "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = {}, keys = { { "<leader>du", function() require("dapui").toggle() end, desc = "Debug UI" } },
  },
  { "leoluz/nvim-dap-go", ft = "go", dependencies = { "mfussenegger/nvim-dap" }, opts = {} },
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "fredrikaverpil/neotest-golang", "marilari88/neotest-vitest" },
    config = function()
      require("neotest").setup({ adapters = { require("neotest-golang")({}), require("neotest-vitest")({}) } })
    end,
    keys = {
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
      { "<leader>tv", function() require("neotest").summary.toggle() end, desc = "Test summary" },
      { "<leader>to", function() require("neotest").output.open() end, desc = "Test output" },
    },
  },
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
  { "eandrju/cellular-automaton.nvim", cmd = "CellularAutomaton", keys = { { "<leader>ca", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain" } } },
  { "vuciv/golf", cmd = "Golf", init = function() vim.g.golf_data_dir = vim.fn.stdpath("data") .. "/golf" end },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "erikbackman/brightburn.vim", lazy = true },
  -- His account-dependent AI plugin is available only when explicitly started.
  { "supermaven-inc/supermaven-nvim", cmd = "SupermavenStart", opts = {} },
}
