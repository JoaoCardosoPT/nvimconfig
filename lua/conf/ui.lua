-- Spinning-cube screenshot palette and a steady block cursor.
local M = {}
function _G.CubeTabline()
  local parts = {}
  for index, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local active = tab == vim.api.nvim_get_current_tabpage()
    local buf = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab))
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
    if name == "" then name = "[No Name]" end
    name = name:gsub("%%", "%%%%")
    local modified = vim.bo[buf].modified and " +" or ""
    parts[#parts + 1] = "%" .. index .. "T%#" .. (active and "TabLineSel" or "TabLine") .. "# " .. name .. modified .. " "
  end
  return table.concat(parts) .. "%T%#TabLineFill#%="
end
-- Native statusline: cyan mode segment followed by a purple file bar.
function _G.CubeStatusline()
  if vim.g.statusline_winid ~= vim.api.nvim_get_current_win() then
    return "%#StatusLineNC# %f%m%r%=%l:%c "
  end
  local modes = {
    n = "NORMAL", i = "INSERT", ic = "INSERT COMPL", ix = "INSERT COMPL GENERIC",
    v = "VISUAL", V = "V-LINE", ["\22"] = "V-BLOCK",
    s = "SELECT", S = "S-LINE", ["\19"] = "S-BLOCK",
    R = "REPLACE", Rv = "V-REPLACE", c = "COMMAND", t = "TERMINAL",
  }
  local mode = vim.fn.mode(1)
  local label = modes[mode] or modes[mode:sub(1, 1)] or "NORMAL"
  return "%#CubeStatusMode# " .. label .. " %#CubeStatusArrow#%#StatusLine# %t%m%r%="
end
function M.setup()
  vim.opt.termguicolors = true
  vim.opt.background = "dark"
  vim.cmd.colorscheme("screenshot-cube")
  vim.opt.number = true
  vim.opt.relativenumber = false
  vim.opt.guicursor = "a:block-Cursor-blinkon0"
  vim.opt.cursorline = false
  vim.opt.cursorlineopt = "both"
  vim.opt.scrolloff = 8
  vim.opt.signcolumn = "auto"
  vim.opt.numberwidth = 4
  vim.opt.colorcolumn = ""
  -- One purple status bar above the charcoal command row.
  vim.opt.laststatus = 3
  vim.opt.cmdheight = 1
  vim.opt.showtabline = 2
  vim.opt.tabline = "%!v:lua.CubeTabline()"
  vim.opt.statusline = "%!v:lua.CubeStatusline()"
  vim.opt.showmode = true
  vim.opt.ruler = false
  vim.diagnostic.config({
    virtual_text = false, virtual_lines = false, signs = false,
    underline = true, update_in_insert = false,
  })
end
return M
