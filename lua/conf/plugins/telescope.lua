return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      path_display = { "smart" },
      file_ignore_patterns = { "node_modules/", "%.git/", "%.venv/", "__pycache__/" },
    },
  },
  keys = {
    { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Prime: find files" },
    { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Prime: Git files" },
    {
      "<leader>ps",
      function()
        local search = vim.fn.input("Grep > ")
        if search ~= "" then require("telescope.builtin").grep_string({ search = search }) end
      end,
      desc = "Prime: search project text",
    },
    { "<leader>pws", "<cmd>Telescope grep_string<cr>", desc = "Prime: search word" },
    {
      "<leader>pWs",
      function() require("telescope.builtin").grep_string({ search = vim.fn.expand("<cWORD>") }) end,
      desc = "Prime: search WORD",
    },
    { "<leader>vh", "<cmd>Telescope help_tags<cr>", desc = "Prime: help" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git files" },
    { "<leader>fr", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find hidden files" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find symbols in file" },
    { "<leader>f?", "<cmd>Telescope keymaps<cr>", desc = "Find keybindings" },
    { "<leader>xw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
  },
}
