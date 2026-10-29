-- Live errors and warnings for the file in the owning editing window.
local M = {}
local title = "File errors and warnings"

local function refresh(win)
  if not vim.api.nvim_win_is_valid(win) then return end
  local buf = vim.api.nvim_win_get_buf(win)
  if vim.bo[buf].buftype ~= "" then return end
  local diagnostics = vim.diagnostic.get(buf, {
    severity = { min = vim.diagnostic.severity.WARN },
  })
  vim.fn.setloclist(win, {}, "r", {
    title = title,
    items = vim.diagnostic.toqflist(diagnostics),
  })
end

function M.toggle()
  local win = vim.api.nvim_get_current_win()
  local list = vim.fn.getloclist(win, { winid = 0, title = 0, filewinid = 0 })
  if list.winid ~= 0 and list.title == title then
    vim.cmd.lclose()
    return
  end
  if list.filewinid and list.filewinid ~= 0 then win = list.filewinid end
  if vim.bo[vim.api.nvim_win_get_buf(win)].buftype ~= "" then return end
  refresh(win)
  vim.api.nvim_win_call(win, function()
    vim.cmd("botright 6lopen")
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.winfixheight = true
    vim.wo.statusline = " File errors and warnings %= Enter: jump | q: close "
    vim.keymap.set("n", "q", "<cmd>lclose<cr>", { buffer = true, silent = true })
  end)
  vim.api.nvim_set_current_win(win)
end

function M.setup()
  vim.keymap.set("n", "<leader>xx", M.toggle, { desc = "Toggle file errors and warnings" })
  local group = vim.api.nvim_create_augroup("FileDiagnosticPanel", { clear = true })
  vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
    group = group,
    callback = function(event)
      if vim.bo[event.buf].buftype ~= "" then return end
      vim.schedule(function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == event.buf then
            local list = vim.fn.getloclist(win, { winid = 0, title = 0 })
            if list.winid ~= 0 and list.title == title then refresh(win) end
          end
        end
      end)
    end,
  })
end

return M
