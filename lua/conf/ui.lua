-- Reference: regular typewriter font, black background, and a plain file tree.
local M = {}
function _G.ColorMyPencils(color)
  vim.opt.background = "dark"
  vim.cmd.colorscheme(color or "ghostty")
end
function M.setup()
  vim.opt.termguicolors = true
  ColorMyPencils()
  -- Courier New is the closest installed match; terminal Neovim inherits it from Ghostty.
  vim.opt.guifont = "Courier New:h17"
  vim.opt.number = true
  vim.opt.relativenumber = false
  vim.opt.numberwidth = 4
  vim.opt.guicursor = "a:block-Cursor-blinkon0"
  vim.opt.cursorline = false
  vim.opt.scrolloff = 4
  vim.opt.signcolumn = "no"
  vim.opt.colorcolumn = ""
  vim.opt.wrap = false
  vim.opt.laststatus = 2
  vim.opt.showtabline = 0
  vim.opt.tabline = ""
  vim.opt.statusline = "%f %m%r%=%l,%c%V          %P"
  vim.opt.showmode = true
  vim.opt.ruler = true
  vim.opt.fillchars:append({ vert = "║", eob = " " })
  vim.diagnostic.config({ float = { border = "rounded", source = "always" } })
end
return M
