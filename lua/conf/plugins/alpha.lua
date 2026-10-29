-- A quiet start screen using the active colorscheme.
return {
  "goolord/alpha-nvim",
  enabled = false, -- Start directly in the editor.
  event = "VimEnter",
  cmd = "Alpha",
  keys = {
    { "<leader>ha", "<cmd>Alpha<cr>", desc = "Open start screen" },
  },
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    local function button(key, label, command)
      local item = dashboard.button(key, label, command)
      item.opts.width = 30
      item.opts.cursor = 0
      item.opts.hl = "Normal"
      item.opts.hl_shortcut = "Comment"
      return item
    end

    dashboard.section.header.val = { "n e o v i m" }
    dashboard.section.header.opts.hl = "Comment"
    dashboard.section.buttons.val = {
      button("n", "New file", "<cmd>ene | startinsert<cr>"),
      button("f", "Find file", "<cmd>Telescope find_files<cr>"),
      button("r", "Recent files", "<cmd>Telescope oldfiles<cr>"),
      button("s", "Search text", "<cmd>Telescope live_grep<cr>"),
      button("q", "Quit", "<cmd>qa<cr>"),
    }
    dashboard.section.buttons.opts.spacing = 1
    dashboard.section.footer.val = function()
      local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      return vim.fn.strcharlen(name) > 36 and vim.fn.strcharpart(name, 0, 33) .. "..." or name
    end
    dashboard.section.footer.opts.hl = "NonText"
    dashboard.config.layout = {
      {
        type = "group",
        val = {
          dashboard.section.header,
          { type = "padding", val = 2 },
          dashboard.section.buttons,
          { type = "padding", val = 1 },
          dashboard.section.footer,
        },
        opts = { position = "v_center" },
      },
    }
    dashboard.config.opts.margin = 2

    local group = vim.api.nvim_create_augroup("MinimalStartScreen", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "alpha",
      callback = function(event)
        local win = vim.api.nvim_get_current_win()
        local statusline = vim.wo[win].statusline
        vim.wo[win].statusline = "%#Normal#"
        vim.api.nvim_create_autocmd("BufWinLeave", {
          group = group,
          buffer = event.buf,
          once = true,
          callback = function()
            if vim.api.nvim_win_is_valid(win) then vim.wo[win].statusline = statusline end
          end,
        })
      end,
    })
    require("alpha").setup(dashboard.config)
  end,
}
