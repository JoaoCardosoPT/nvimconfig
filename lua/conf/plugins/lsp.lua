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
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
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
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      {
        "zbirenbaum/copilot-cmp",
        main = "copilot_cmp",
        opts = {},
        config = function(_, opts)
          -- Use the current LSP client API until copilot-cmp updates upstream.
          local source = require("copilot_cmp.source")
          function source:is_available()
            local client = self.client
            return not client:is_stopped()
              and client.name == "copilot"
              and vim.lsp.buf_is_attached(0, client.id)
          end
          require("copilot_cmp").setup(opts)
        end,
        dependencies = {
          { "saghen/blink.compat", version = "2.*", opts = {} },
          {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            opts = {
              suggestion = {
                enabled = true,
                auto_trigger = true,
                hide_during_completion = true,
              },
              panel = { enabled = false },
            },
            config = function(_, opts)
              require("copilot").setup(opts)
              local group = vim.api.nvim_create_augroup("CopilotBlinkSuggestions", { clear = true })
              vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "BlinkCmpMenuOpen",
                callback = function() vim.b.copilot_suggestion_hidden = true end,
              })
              vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "BlinkCmpMenuClose",
                callback = function() vim.b.copilot_suggestion_hidden = false end,
              })
            end,
          },
        },
      },
    },
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "default",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          "select_next",
          function()
            local luasnip = require("luasnip")
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
              return true
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          function()
            local luasnip = require("luasnip")
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
              return true
            end
          end,
          "fallback",
        },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          buffer = { min_keyword_length = 3 },
          copilot = {
            name = "copilot",
            module = "blink.compat.source",
            async = true,
          },
        },
      },
    },
  },
}
