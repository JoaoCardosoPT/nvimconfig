local lsp_servers = {
  "clangd",
  "cssls",
  "html",
  "lua_ls",
  "pyright",
  "ts_ls",
  "rust_analyzer",
  "gopls",
  "tailwindcss",
}

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    -- Let Vim syntax files own the colors, even with a language server attached.
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
    local function lsp_map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = desc })
    end

    lsp_map("K", vim.lsp.buf.hover, "LSP hover")
    lsp_map("<leader>k", vim.diagnostic.open_float, "Line diagnostics")
    lsp_map("gd", vim.lsp.buf.definition, "Go to definition")
    lsp_map("gD", vim.lsp.buf.declaration, "Go to declaration")
    lsp_map("gi", vim.lsp.buf.implementation, "Go to implementation")
    lsp_map("go", vim.lsp.buf.type_definition, "Go to type definition")
    lsp_map("gr", vim.lsp.buf.references, "List references")
    lsp_map("gs", vim.lsp.buf.signature_help, "Signature help")
    lsp_map("<F2>", vim.lsp.buf.rename, "Rename symbol")
    lsp_map("<F4>", vim.lsp.buf.code_action, "Code action")
  end,
})

return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
        automatic_enable = lsp_servers,
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        preselect = cmp.PreselectMode.None,
        completion = { autocomplete = { cmp.TriggerEvent.TextChanged } },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "luasnip" },
          { name = "buffer", keyword_length = 3 },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    end,
  },
}
