-- Vivid classic syntax with a terminal-matched background for transparency.
vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "screenshot-classic"

local p = {
  bg = "#000000", fg = "#d0d0d0", panel = "#090b12", line = "#171a25",
  selection = "#272b3d", comment = "#65bdb5", muted = "#757985",
  pink = "#f27993", green = "#c6e873", yellow = "#cece68",
  cyan = "#65c7be", purple = "#b04bb5", orange = "#ffc17a",
}
local function hi(name, value)
  vim.api.nvim_set_hl(0, name, value)
end
local groups = {
  Normal = { fg = p.fg, bg = p.bg },
  NormalNC = { fg = p.fg, bg = p.bg },
  NormalFloat = { fg = p.fg, bg = p.panel },
  FloatBorder = { fg = p.comment, bg = p.panel },
  FloatTitle = { fg = p.fg, bg = p.panel, bold = true },
  Cursor = { fg = p.bg, bg = "#d0d0d0" },
  CursorLine = { bg = p.line },
  CursorColumn = { bg = p.line },
  ColorColumn = { bg = p.line },
  LineNr = { fg = p.yellow, bold = true },
  CursorLineNr = { fg = p.yellow, bold = true },
  SignColumn = { bg = p.bg },
  EndOfBuffer = { fg = p.bg },
  NonText = { fg = p.comment },
  Whitespace = { fg = p.line },
  Visual = { bg = p.selection },
  Search = { fg = p.bg, bg = p.yellow },
  IncSearch = { fg = p.bg, bg = p.orange },
  CurSearch = { fg = p.bg, bg = p.orange },
  MatchParen = { fg = p.fg, bg = p.selection, bold = true },
  StatusLine = { fg = p.fg, bg = p.selection },
  StatusLineNC = { fg = p.muted, bg = p.panel },
  WinSeparator = { fg = p.line, bg = p.bg },
  TabLine = { fg = p.muted, bg = p.panel },
  TabLineFill = { bg = p.panel },
  TabLineSel = { fg = p.fg, bg = p.selection },
  Pmenu = { fg = p.fg, bg = p.panel },
  PmenuSel = { fg = p.fg, bg = p.selection },
  PmenuSbar = { bg = p.line },
  PmenuThumb = { bg = p.comment },
  Folded = { fg = p.comment, bg = p.line },
  FoldColumn = { fg = p.comment, bg = p.bg },
  Directory = { fg = "#65c7be" },
  Title = { fg = p.green, bold = true },
  Comment = { fg = p.comment, bold = true },
  Constant = { fg = p.purple },
  String = { fg = p.purple },
  Character = { fg = p.purple },
  Number = { fg = p.purple },
  Boolean = { fg = p.cyan, bold = true },
  Float = { fg = p.purple },
  Identifier = { fg = p.fg },
  Function = { fg = p.fg },
  Statement = { fg = p.yellow, bold = true },
  Operator = { fg = p.fg },
  Keyword = { fg = p.yellow, bold = true },
  PreProc = { fg = p.yellow },
  Type = { fg = "#65c7be" },
  StorageClass = { fg = p.yellow },
  Structure = { fg = "#65c7be" },
  Typedef = { fg = "#65c7be" },
  Special = { fg = p.orange },
  Delimiter = { fg = p.fg },
  Underlined = { fg = p.cyan, underline = true },
  Todo = { fg = p.orange, bold = true },
  Error = { fg = p.pink, bg = p.panel },
  ErrorMsg = { fg = p.pink },
  WarningMsg = { fg = p.orange },
  MoreMsg = { fg = p.green },
  Question = { fg = p.cyan },
  DiffAdd = { bg = "#354028" },
  DiffChange = { bg = "#37352c" },
  DiffDelete = { fg = p.pink, bg = "#482b32" },
  DiffText = { bg = "#504b30" },
  ["@variable"] = { fg = p.fg },
  ["@variable.parameter"] = { fg = p.fg },
  ["@variable.builtin"] = { fg = p.fg },
  ["@property"] = { fg = p.fg },
  ["@tag"] = { fg = p.pink },
  ["@tag.attribute"] = { fg = p.green },
  ["@markup.heading"] = { fg = p.green, bold = true },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  NvimTreeNormal = { fg = p.fg, bg = p.bg },
  NvimTreeFolderName = { fg = "#65c7be" },
  NvimTreeOpenedFolderName = { fg = "#65c7be" },
  NvimTreeRootFolder = { fg = p.green, bold = true },
  NvimTreeCursorLine = { bg = p.selection },
  TelescopeNormal = { fg = p.fg, bg = p.panel },
  TelescopeBorder = { fg = p.comment, bg = p.panel },
  TelescopeSelection = { bg = p.selection },
  TelescopeMatching = { fg = p.green, bold = true },
}
for name, value in pairs(groups) do hi(name, value) end

local links = {
  ["@function"] = "Function", ["@function.builtin"] = "Function",
  ["@function.call"] = "Function", ["@function.method"] = "Function",
  ["@function.method.call"] = "Function", ["@constructor"] = "Type",
  ["@type"] = "Type", ["@type.builtin"] = "Type",
  ["@keyword"] = "Keyword", ["@operator"] = "Operator",
  ["@constant"] = "Constant", ["@constant.builtin"] = "Constant",
  ["@string"] = "String", ["@string.escape"] = "Special",
  ["@number"] = "Number", ["@boolean"] = "Boolean",
  ["@comment"] = "Comment", ["@punctuation"] = "Delimiter",
  ["@module"] = "Identifier", ["@label"] = "Statement",
  ["@lsp.type.variable"] = "@variable", ["@lsp.type.parameter"] = "@variable.parameter",
  ["@lsp.type.property"] = "@property", ["@lsp.type.function"] = "Function",
  ["@lsp.type.method"] = "Function", ["@lsp.type.class"] = "Type",
  ["@lsp.type.struct"] = "Type", ["@lsp.type.enum"] = "Type",
  ["@lsp.type.enumMember"] = "Constant", ["@lsp.type.namespace"] = "Identifier",
  ["@lsp.type.macro"] = "PreProc", NvimTreeNormalNC = "NvimTreeNormal",
}
for name, target in pairs(links) do hi(name, { link = target }) end
for severity, color in pairs({ Error = p.pink, Warn = p.orange, Info = p.cyan, Hint = p.green }) do
  hi("Diagnostic" .. severity, { fg = color })
  hi("DiagnosticUnderline" .. severity, { sp = color, undercurl = true })
end
for name, color in pairs({ Add = p.green, Change = p.yellow, Delete = p.pink }) do
  hi("GitSigns" .. name, { fg = color })
end
local ansi = {
  "#000000", "#f27993", "#b7df83", "#cece68", "#8daeff", "#b04bb5", "#65c7be", "#d0d0d0",
  "#5c606c", "#ff9cb1", "#d1f59b", "#fff29b", "#b1c7ff", "#e7b0ff", "#a0f4eb", "#f5f5f7",
}
for index, color in ipairs(ansi) do vim.g["terminal_color_" .. (index - 1)] = color end

-- File-browser colors matching the reference.
hi("netrwDir", { fg = "#65c7be" })
hi("netrwClassify", { fg = "#ffc17a" })
hi("netrwTreeBar", { fg = "#65c7be" })
hi("netrwPlain", { fg = "#d0d0d0" })
hi("NvimTreeFolderIcon", { fg = "#ffc17a" })
hi("NvimTreeIndentMarker", { fg = "#65c7be" })

-- Vim's standard C syntax leaves function calls uncolored.
local function c_functions()
  vim.cmd([[syntax match ScreenshotFunction /\<\h\w*\ze\s*(/ contains=cStatement,cConditional,cRepeat,cOperator,cType,cStorageClass]])
end
local group = vim.api.nvim_create_augroup("ScreenshotClassicSyntax", { clear = true })
vim.api.nvim_create_autocmd("Syntax", { group = group, pattern = { "c", "cpp" }, callback = c_functions })
if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then c_functions() end
hi("ScreenshotFunction", { link = "Function" })

-- Python built-ins and booleans are teal in the reference.
hi("pythonBuiltin", { fg = p.cyan, bold = true })
hi("pythonBoolean", { fg = p.cyan, bold = true })
hi("pythonException", { fg = p.fg })
hi("pythonExceptions", { fg = p.fg })
hi("pythonFunction", { fg = p.fg })

-- Match Python's classic syntax even when Treesitter is active.
hi("@function.builtin.python", { fg = p.cyan, bold = true })
hi("@constant.builtin.python", { fg = p.cyan, bold = true })
hi("@type.builtin.python", { fg = p.cyan, bold = true })
hi("@keyword.operator", { link = "Keyword" })
hi("@string.escape", { link = "String" })
hi("@string.regexp", { link = "String" })
hi("@variable.member", { link = "Identifier" })
hi("@lsp.type.decorator", { link = "PreProc" })
