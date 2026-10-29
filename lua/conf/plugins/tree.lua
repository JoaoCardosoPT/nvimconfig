return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    require("nvim-tree").setup({
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      view = { width = 30, side = "left", signcolumn = "no" },
      renderer = {
        root_folder_label = ":~",
        highlight_git = "name",
        indent_markers = { enable = false },
        icons = {
          git_placement = "before",
          -- Consistent outline glyphs instead of colorful file-type logos.
          web_devicons = { file = { enable = false }, folder = { enable = false } },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            modified = "○",
            folder = {
              arrow_closed = "", arrow_open = "",
              default = "", open = "",
              empty = "", empty_open = "",
              symlink = "", symlink_open = "",
            },
            git = {
              unstaged = "~", staged = "+", untracked = "?",
              unmerged = "!", renamed = "→", deleted = "−", ignored = "·",
            },
          },
        },
      },
      filters = { dotfiles = false, git_ignored = false },
      update_focused_file = { enable = true },
      actions = { open_file = { quit_on_open = false, resize_window = false } },
    })
    local api = require("nvim-tree.api")
    vim.keymap.set("n", "<leader>e", api.tree.toggle, { desc = "Toggle file tree" })
    vim.keymap.set("n", "<leader>E", api.tree.find_file, { desc = "Reveal file in tree" })
    local group = vim.api.nvim_create_augroup("ReferenceFileTree", { clear = true })
    vim.api.nvim_create_autocmd("VimEnter", {
      group = group,
      callback = function()
        -- Avoid changing piped input, diff sessions, or headless jobs.
        if #vim.api.nvim_list_uis() == 0 or vim.o.diff or vim.fn.argc() > 1 then return end
        if vim.bo.buftype ~= "" then return end
        local name = vim.api.nvim_buf_get_name(0)
        if name ~= "" and vim.fn.isdirectory(name) == 0 and vim.fn.filereadable(name) == 0 then return end
        api.tree.open({ focus = false })
      end,
    })
  end,
}
