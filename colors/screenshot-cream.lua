-- Cream screenshot palette with Tree-sitter and LSP highlights.
vim.o.background = "light"
vim.cmd("highlight clear")
vim.g.colors_name = "screenshot-cream"

local p = {
  bg = "#fdf6e3", fg = "#839496", panel = "#eee8d5", line = "#f3eddb",
  selection = "#e4e0cb", comment = "#93a1a1", muted = "#839496",
  pink = "#859900", green = "#268bd2", yellow = "#2aa198",
  cyan = "#b58900", purple = "#d33682", orange = "#cb4b16",
}
local function hi(name, value)
  vim.api.nvim_set_hl(0, name, value)
end
local groups = {
  CubeStatusMode = { fg = "#073642", bg = p.cyan, bold = true },
  CubeStatusArrow = { fg = p.cyan, bg = p.panel },
  ReferenceTerminal = { fg = p.fg, bg = p.bg },
  ReferenceTerminalMode = { fg = "#073642", bg = p.cyan },
  ReferenceTerminalArrow = { fg = p.cyan, bg = p.panel },
  MsgArea = { fg = p.fg, bg = p.bg },
  ModeMsg = { fg = p.cyan },
  QuickFixLine = { fg = p.bg, bg = p.cyan },
  Normal = { fg = p.fg, bg = p.bg },
  NormalNC = { fg = p.fg, bg = p.bg },
  NormalFloat = { fg = p.fg, bg = p.panel },
  FloatBorder = { fg = p.comment, bg = p.panel },
  FloatTitle = { fg = p.fg, bg = p.panel, bold = true },
  Cursor = { fg = p.bg, bg = "#808080" },
  CursorLine = { bg = p.line },
  CursorColumn = { bg = p.line },
  ColorColumn = { bg = p.line },
  LineNr = { fg = p.comment, bg = p.panel },
  CursorLineNr = { fg = p.cyan, bg = p.panel },
  SignColumn = { bg = p.bg },
  EndOfBuffer = { fg = p.bg },
  NonText = { fg = p.comment },
  Whitespace = { fg = p.line },
  Visual = { bg = p.selection },
  Search = { fg = p.bg, bg = p.yellow },
  IncSearch = { fg = p.bg, bg = p.orange },
  CurSearch = { fg = p.bg, bg = p.orange },
  MatchParen = { fg = p.fg, bg = p.selection, bold = true },
  StatusLine = { fg = "#657b83", bg = p.panel },
  StatusLineNC = { fg = p.muted, bg = p.panel },
  WinSeparator = { fg = p.line, bg = p.bg },
  TabLine = { fg = p.muted, bg = p.panel },
  TabLineFill = { bg = p.panel },
  TabLineSel = { fg = p.bg, bg = p.cyan },
  Pmenu = { fg = p.fg, bg = p.panel },
  PmenuSel = { fg = p.fg, bg = p.selection },
  PmenuSbar = { bg = p.line },
  PmenuThumb = { bg = p.comment },
  Folded = { fg = p.comment, bg = p.line },
  FoldColumn = { fg = p.comment, bg = p.bg },
  Directory = { fg = p.green },
  Title = { fg = p.green, bold = true },
  Comment = { fg = p.comment },
  Constant = { fg = p.yellow },
  String = { fg = p.yellow },
  Character = { fg = "#dc322f" },
  Number = { fg = p.yellow },
  Boolean = { fg = p.yellow },
  Float = { fg = p.yellow },
  Identifier = { fg = p.fg },
  Function = { fg = p.fg },
  Statement = { fg = p.pink },
  Operator = { fg = p.fg },
  Keyword = { fg = p.pink },
  PreProc = { fg = p.pink },
  Type = { fg = p.cyan },
  StorageClass = { fg = p.pink },
  Structure = { fg = p.cyan },
  Typedef = { fg = p.cyan },
  Special = { fg = p.purple },
  Delimiter = { fg = p.fg },
  Underlined = { fg = p.cyan, underline = true },
  Todo = { fg = p.orange, bold = true },
  Error = { fg = "#dc322f", bg = p.panel },
  ErrorMsg = { fg = "#dc322f" },
  WarningMsg = { fg = p.orange },
  MoreMsg = { fg = p.green },
  Question = { fg = p.cyan },
  DiffAdd = { bg = "#e5edce" },
  DiffChange = { bg = "#e6ece4" },
  DiffDelete = { fg = "#dc322f", bg = "#f7dfd5" },
  DiffText = { bg = "#d2e5dc" },
  ["@variable"] = { fg = p.fg },
  ["@variable.parameter"] = { fg = p.fg },
  ["@variable.builtin"] = { fg = p.cyan },
  ["@property"] = { fg = p.fg },
  ["@variable.member"] = { fg = p.fg },
  ["@tag"] = { fg = p.pink },
  ["@tag.attribute"] = { fg = p.green },
  ["@markup.heading"] = { fg = p.green, bold = true },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  NvimTreeNormal = { fg = p.fg, bg = p.panel },
  NvimTreeFolderName = { fg = p.fg },
  NvimTreeOpenedFolderName = { fg = p.fg, bold = true },
  NvimTreeRootFolder = { fg = p.fg, bold = true },
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
for severity, color in pairs({ Error = "#dc322f", Warn = p.orange, Info = p.cyan, Hint = p.green }) do
  hi("Diagnostic" .. severity, { fg = color })
  hi("DiagnosticUnderline" .. severity, { sp = color, undercurl = true })
end
for name, color in pairs({ Add = p.green, Change = p.yellow, Delete = "#dc322f" }) do
  hi("GitSigns" .. name, { fg = color })
end
local ansi = {
  "#073642", "#dc322f", "#859900", "#b58900", "#268bd2", "#d33682", "#2aa198", "#eee8d5", "#002b36", "#cb4b16", "#586e75", "#657b83", "#839496", "#6c71c4", "#93a1a1", "#fdf6e3"
}
for index, color in ipairs(ansi) do vim.g["terminal_color_" .. (index - 1)] = color end
