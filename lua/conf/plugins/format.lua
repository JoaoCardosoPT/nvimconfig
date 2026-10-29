return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  dependencies = { "mason-org/mason.nvim" },
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "x" },
      desc = "Format file or selection",
    },
    {
      "<leader>cF",
      function()
        vim.b.autoformat = not vim.b.autoformat
        vim.notify("Format on save: " .. (vim.b.autoformat and "on" or "off"))
      end,
      desc = "Toggle format on save for this buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      python = { "ruff_format" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      lua = { "stylua" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      sh = { "shfmt" },
    },
    format_on_save = function(buf)
      if vim.b[buf].autoformat then
        return { timeout_ms = 2000, lsp_format = "fallback" }
      end
    end,
  },
}
