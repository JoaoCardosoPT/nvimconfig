-- Plain netrw listing in a left-hand sidebar.
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_winsize = -35
vim.g.netrw_keepdir = 1
vim.g.netrw_cursor = 2
vim.g.netrw_special_syntax = 0
vim.g.netrw_sort_sequence = [[[\/]$,*]]
vim.g.netrw_bufsettings = "noma nomod nonu nobl nowrap ro nornu signcolumn=no foldcolumn=0"

local group = vim.api.nvim_create_augroup("PlainFileExplorer", { clear = true })
local saved_highlights = {}

local function colors()
  vim.api.nvim_set_hl(0, "PlainExplorerNormal", { link = "Normal" })
  vim.api.nvim_set_hl(0, "PlainExplorerCursorLine", { link = "CursorLine" })
  vim.api.nvim_set_hl(0, "PlainExplorerEndOfBuffer", { link = "EndOfBuffer" })
  for _, name in ipairs({ "netrwDir", "netrwClassify", "netrwPlain", "netrwExe", "netrwLink", "netrwSymLink" }) do
    vim.api.nvim_set_hl(0, name, { link = "PlainExplorerNormal" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = colors })
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  group = group,
  callback = function(event)
    if vim.bo[event.buf].filetype ~= "netrw" then return end
    colors()
    local win = vim.api.nvim_get_current_win()
    saved_highlights[win] = saved_highlights[win] or vim.wo[win].winhighlight
    vim.wo[win].winhighlight = "Normal:PlainExplorerNormal,NormalNC:PlainExplorerNormal,CursorLine:PlainExplorerCursorLine,EndOfBuffer:PlainExplorerEndOfBuffer"
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.wo[win].signcolumn = "no"
    vim.wo[win].cursorline = true
    vim.wo[win].cursorlineopt = "line"
  end,
})
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = group,
  callback = function(event)
    if vim.bo[event.buf].filetype ~= "netrw" then return end
    local win = vim.api.nvim_get_current_win()
    if saved_highlights[win] ~= nil then
      vim.wo[win].winhighlight = saved_highlights[win]
      saved_highlights[win] = nil
    end
  end,
})

local function explore_current_directory()
  local path = vim.fn.expand("%:p:h")
  if vim.bo.filetype == "netrw" then path = vim.b.netrw_curdir end
  if vim.bo.filetype == "netrw" and vim.fn.winnr("$") == 1 then
    -- Leave an editing window when converting a fullscreen browser.
    vim.cmd.enew()
  elseif vim.t.netrw_lexbufnr and vim.fn.bufwinnr(vim.t.netrw_lexbufnr) > 0 then
    vim.cmd.Lexplore()
    return
  end
  vim.cmd.Lexplore(vim.fn.fnameescape(path or vim.fn.getcwd()))
end

for _, key in ipairs({ "<leader>e", "<leader>E" }) do
  vim.keymap.set("n", key, explore_current_directory, { desc = "Toggle file explorer sidebar" })
end
