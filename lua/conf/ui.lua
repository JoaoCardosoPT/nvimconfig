-- Layout and colors matched to the supplied C editing screenshot.
local M = {}
function _G.ColorMyPencils(color)
  vim.opt.background = "dark"
  vim.cmd.colorscheme(color or "screenshot-video")
end
function M.setup()
  vim.opt.termguicolors = true
  ColorMyPencils()
  vim.opt.guifont = "Consolas for Powerline:h17"
  vim.opt.number = true
  vim.opt.relativenumber = false
  vim.opt.numberwidth = 4
  vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr:hor20-Cursor,a:blinkon0"
  vim.opt.cursorline = false
  vim.opt.scrolloff = 4
  vim.opt.signcolumn = "no"
  vim.opt.colorcolumn = ""
  vim.opt.wrap = false
  vim.opt.laststatus = 2
  vim.opt.showtabline = 2
  vim.opt.tabline = ""
  vim.opt.statusline = "%f %m%r%=%l,%c%V          %P"
  vim.opt.showmode = true
  vim.opt.ruler = true
  vim.opt.fillchars:append({ vert = "│", eob = " " })
  vim.diagnostic.config({ float = { border = "rounded", source = "always" } })
end
return M
