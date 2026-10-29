vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { silent = true }

map("", "<Space>", "<Nop>", opts)

-- File browser and search mappings live in plugins/tree.lua and plugins/telescope.lua.

-- Window navigation and resizing.
map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
map("n", "<C-Up>", "<cmd>resize +1<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -1<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -1<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +1<cr>", { desc = "Increase window width" })

-- Keep the cursor centered and move between buffers.
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "Q", "<Nop>", opts)

-- Move selected lines and preserve the copied text when pasting over a selection.
map("v", "<A-j>", ":m .+1<cr>==", opts)
map("v", "<A-k>", ":m .-2<cr>==", opts)
map("v", "p", '"_dP', opts)
map("x", "J", ":move '>+1<cr>gv=gv", opts)
map("x", "K", ":move '<-2<cr>gv=gv", opts)
map("x", "<A-j>", ":move '>+1<cr>gv=gv", opts)
map("x", "<A-k>", ":move '<-2<cr>gv=gv", opts)
map("x", "p", '"_dP', opts)

-- Navigate terminal splits without leaving terminal mode manually.
map("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
map("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)

-- Prime's editing motions; window navigation stays on Ctrl-h/j/k/l.
map("n", "J", "mzJ`z", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("x", "<leader>p", '"_dP', opts)
map({ "n", "v" }, "<leader>y", '"+y', opts)
map("n", "<leader>Y", '"+Y', opts)
map({ "n", "v" }, "<leader>d", '"_d', opts)
