-- Warm near-black and muted syntax, matched to the October 23 screenshot.
vim.o.background = "dark"
vim.cmd("highlight clear")
vim.g.colors_name = "screenshot-warm"

local p = {
  bg = "#0f0c00", fg = "#b7b8b2", muted = "#68676b",
  sage = "#788477", pink = "#bea39b", type = "#a9b8b3",
  panel = "#1c1b18", bar = "#282828", inactive = "#1f1f1f",
  selection = "#33322c", yellow = "#b4aa88", red = "#b87f78",
}
local function hi(name, value) vim.api.nvim_set_hl(0, name, value) end
local groups = {
  Normal = { fg = p.fg, bg = p.bg },
  NormalNC = { fg = p.fg, bg = p.bg },
  NormalFloat = { fg = p.fg, bg = p.panel },
  FloatBorder = { fg = p.muted, bg = p.panel },
  FloatTitle = { fg = p.type, bg = p.panel },
  Cursor = { fg = p.bg, bg = p.fg },
  CursorLine = { bg = p.panel },
  CursorColumn = { bg = p.panel },
  ColorColumn = { bg = p.panel },
  LineNr = { fg = p.muted, bg = p.bg },
  CursorLineNr = { fg = p.muted, bg = p.bg },
  SignColumn = { bg = p.bg },
  EndOfBuffer = { fg = p.bg, bg = p.bg },
  NonText = { fg = p.muted },
  Whitespace = { fg = p.panel },
  Visual = { bg = p.selection },
  Search = { fg = p.bg, bg = p.yellow },
  IncSearch = { fg = p.bg, bg = p.pink },
  CurSearch = { fg = p.bg, bg = p.pink },
  MatchParen = { fg = p.fg, bg = p.selection },
  StatusLine = { fg = "#8b8992", bg = p.bar },
  StatusLineNC = { fg = "#73717a", bg = p.inactive },
  WinSeparator = { fg = p.bar, bg = p.bg },
  TabLine = { fg = p.muted, bg = p.inactive },
  TabLineFill = { bg = p.inactive },
  TabLineSel = { fg = p.fg, bg = p.bar },
  Pmenu = { fg = p.fg, bg = p.panel },
  PmenuSel = { fg = p.fg, bg = p.selection },
  PmenuSbar = { bg = p.bar },
  PmenuThumb = { bg = p.muted },
  Folded = { fg = p.sage, bg = p.panel },
  FoldColumn = { fg = p.muted, bg = p.bg },
  Directory = { fg = p.type },
  Title = { fg = p.type },
  Comment = { fg = p.muted },
  Constant = { fg = p.pink },
  String = { fg = p.pink },
  Character = { fg = p.pink },
  Number = { fg = p.pink },
  Boolean = { fg = p.pink },
  Float = { fg = p.pink },
  Identifier = { fg = p.fg },
  Function = { fg = p.pink },
  Statement = { fg = p.sage },
  Operator = { fg = p.muted },
  Keyword = { fg = p.sage },
  PreProc = { fg = p.sage },
  Type = { fg = p.type },
  StorageClass = { fg = p.sage },
  Structure = { fg = p.sage },
  Typedef = { fg = p.type },
  Special = { fg = p.pink },
  Delimiter = { fg = p.muted },
  Underlined = { fg = p.type, underline = true },
  Todo = { fg = p.yellow },
  Error = { fg = p.red, bg = p.panel },
  ErrorMsg = { fg = p.red },
  WarningMsg = { fg = p.yellow },
  MoreMsg = { fg = p.sage },
  Question = { fg = p.type },
  ModeMsg = { fg = p.muted },
  DiffAdd = { bg = "#22291d" },
  DiffChange = { bg = "#29271c" },
  DiffDelete = { fg = p.red, bg = "#30201d" },
  DiffText = { bg = "#3c3827" },
  TelescopeNormal = { fg = p.fg, bg = p.panel },
  TelescopeBorder = { fg = p.muted, bg = p.panel },
  TelescopeSelection = { bg = p.selection },
  TelescopeMatching = { fg = p.pink },
}
for name, value in pairs(groups) do hi(name, value) end

local links = {
  ["@variable"] = "Identifier", ["@variable.parameter"] = "Identifier",
  ["@variable.member"] = "Identifier", ["@variable.builtin"] = "Identifier",
  ["@property"] = "Identifier", ["@module"] = "Keyword",
  ["@function"] = "Function", ["@function.builtin"] = "Function",
  ["@function.call"] = "Function", ["@function.method"] = "Function",
  ["@function.method.call"] = "Function", ["@function.macro"] = "Function",
  ["@constructor"] = "Type", ["@type"] = "Type", ["@type.builtin"] = "Type",
  ["@keyword"] = "Keyword", ["@operator"] = "Operator",
  ["@constant"] = "Constant", ["@constant.builtin"] = "Constant",
  ["@string"] = "String", ["@string.escape"] = "String",
  ["@string.regexp"] = "String", ["@character"] = "Character",
  ["@number"] = "Number", ["@boolean"] = "Boolean",
  ["@comment"] = "Comment", ["@punctuation"] = "Delimiter",
  ["@label"] = "Statement", ["@tag"] = "Type", ["@tag.attribute"] = "Identifier",
  ["@tag.delimiter"] = "Delimiter", ["@markup.heading"] = "Title",
  ["@lsp.type.variable"] = "Identifier", ["@lsp.type.parameter"] = "Identifier",
  ["@lsp.type.property"] = "Identifier", ["@lsp.type.function"] = "Function",
  ["@lsp.type.method"] = "Function", ["@lsp.type.class"] = "Type",
  ["@lsp.type.struct"] = "Type", ["@lsp.type.enum"] = "Type",
  ["@lsp.type.enumMember"] = "Constant", ["@lsp.type.namespace"] = "Keyword",
  ["@lsp.type.macro"] = "Function", ["@lsp.type.decorator"] = "PreProc",
  NvimTreeNormal = "Normal", NvimTreeNormalNC = "NormalNC",
  NvimTreeRootFolder = "Directory", NvimTreeFolderName = "Directory",
  NvimTreeOpenedFolderName = "Directory", NvimTreeFolderIcon = "Directory",
  NvimTreeIndentMarker = "NonText", NvimTreeCursorLine = "Visual",
  netrwDir = "Directory", netrwClassify = "Delimiter", netrwPlain = "Normal",
  rustModPath = "Keyword", rustFuncCall = "Function", rustMacro = "Function",
  rustSigil = "Delimiter", rustQuestionMark = "Delimiter",
}
for name, target in pairs(links) do hi(name, { link = target }) end
for severity, color in pairs({ Error = p.red, Warn = p.yellow, Info = p.type, Hint = p.sage }) do
  hi("Diagnostic" .. severity, { fg = color })
  hi("DiagnosticUnderline" .. severity, { sp = color, undercurl = true })
end
for name, color in pairs({ Add = p.sage, Change = p.yellow, Delete = p.red }) do
  hi("GitSigns" .. name, { fg = color })
end
local ansi = {
  p.bg, p.red, p.sage, p.yellow, "#8697a0", p.pink, p.type, p.fg,
  p.muted, "#c99189", "#93a18c", "#c7bc9c", "#a1b0b8", "#d1b5ad", "#bfd0c9", "#d0d0c8",
}
for index, color in ipairs(ansi) do vim.g["terminal_color_" .. (index - 1)] = color end
