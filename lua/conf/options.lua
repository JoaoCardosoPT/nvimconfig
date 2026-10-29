local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menu", "menuone", "noselect" },
  conceallevel = 0,
  cursorline = false,
  expandtab = true,
  fileencoding = "utf-8",
  guifont = "JetBrainsMono Nerd Font Mono:h24",
  guicursor = "a:block-Cursor-blinkon0",
  smoothscroll = false,
  hlsearch = false,
  ignorecase = true,
  incsearch = true,
  mouse = "",
  number = true,
  numberwidth = 4,
  pumheight = 10,
  relativenumber = false,
  scrolloff = 4,
  shiftwidth = 4,
  shortmess = vim.opt.shortmess + "c",
  showmode = true,
  showtabline = 1,
  sidescrolloff = 4,
  signcolumn = "auto",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 4,
  termguicolors = true,
  timeoutlen = 1000,
  undofile = true,
  updatetime = 50,
  wrap = true,
  linebreak = true,
  breakindent = true,
  writebackup = false,
  wildmenu = true,
  wildmode = "longest:full,full",
  wildoptions = "",
}

for name, value in pairs(options) do
  vim.opt[name] = value
end

-- Native :find completion searches below the current working directory.
vim.opt.path:append("**")
vim.opt.wildignore:append({ "*/.git/*", "*/node_modules/*", "*/.venv/*" })
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

local filetype_settings = vim.api.nvim_create_augroup("FileTypeSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = filetype_settings,
  pattern = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "typescript",
    "typescriptreact",
  },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = filetype_settings,
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})
