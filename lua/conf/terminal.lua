-- One persistent, full-width bottom terminal, using Neovim's built-in terminal.
local M = {}
local terminal_buf
local function decorate()
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"
  vim.wo.cursorline = false
  vim.wo.winfixheight = true
  vim.wo.winhighlight = ""
  vim.wo.statusline = " TERMINAL %{fnamemodify(&shell, ':t')} %= %l:%c "
end
function M.toggle()
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    local win = vim.fn.bufwinid(terminal_buf)
    if win ~= -1 then
      if #vim.api.nvim_tabpage_list_wins(0) > 1 then
        vim.api.nvim_win_hide(win)
      else
        vim.cmd.enew()
      end
      return
    end
  else
    terminal_buf = nil
  end
  local height = math.max(8, math.floor(vim.o.lines * 0.32))
  vim.cmd("botright " .. height .. "new")
  if terminal_buf then
    vim.api.nvim_win_set_buf(0, terminal_buf)
  else
    terminal_buf = vim.api.nvim_get_current_buf()
    vim.bo.bufhidden = "hide"
    vim.fn.jobstart(vim.o.shell, { term = true })
  end
  decorate()
  vim.cmd.startinsert()
end
function M.setup()
  vim.keymap.set({ "n", "t" }, "<C-\\>", M.toggle, { desc = "Toggle bottom terminal" })
  vim.keymap.set("n", "<leader>ot", M.toggle, { desc = "Toggle bottom terminal" })
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Leave terminal input mode" })
  local group = vim.api.nvim_create_augroup("ReferenceTerminal", { clear = true })
  vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = function()
      local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
      vim.b.terminal_color_background = normal.bg and string.format("#%06x", normal.bg) or nil
      decorate()
    end,
  })
  vim.api.nvim_create_autocmd("TermClose", {
    group = group,
    callback = function(event)
      if event.buf == terminal_buf then
        terminal_buf = nil
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(event.buf) then
            vim.api.nvim_buf_delete(event.buf, { force = true })
          end
        end)
      end
    end,
  })
end
return M
