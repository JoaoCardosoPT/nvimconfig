-- Charcoal and neutral gray with muted syntax colors and a cyan accent.
vim.o.background = "dark"
vim.cmd("highlight clear")
vim.g.colors_name = "screenshot-cube"

local p = {
  bg = "#262626", fg = "#d0d0d0", muted = "#707070",
  sage = "#9da696", pink = "#ad929f", type = "#b9b9b2",
  panel = "#303030", bar = "#1c1c1c", inactive = "#202020",
  selection = "#444444", yellow = "#b9b9b2", red = "#b58a8a",
  cyan = "#00bfe8", purple = "#5f005f", amber = "#e5ad46",
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
  EndOfBuffer = { fg = "#555555", bg = p.bg },
  NonText = { fg = p.muted },
  Whitespace = { fg = p.panel },
  Visual = { bg = p.selection },
  Search = { fg = p.bg, bg = p.yellow },
  IncSearch = { fg = p.bg, bg = p.pink },
  CurSearch = { fg = p.bg, bg = p.pink },
  MatchParen = { fg = p.fg, bg = p.selection },
  StatusLine = { fg = "#ffffff", bg = p.purple },
  MsgArea = { fg = p.fg, bg = p.bg },
  CubeStatusMode = { fg = p.bg, bg = p.cyan },
  CubeStatusArrow = { fg = p.cyan, bg = p.purple },
  StatusLineNC = { fg = "#73717a", bg = p.inactive },
  WinSeparator = { fg = p.bar, bg = p.bg },
  TabLine = { fg = p.muted, bg = p.inactive },
  TabLineFill = { bg = p.inactive },
  TabLineSel = { fg = p.bar, bg = p.cyan, bold = true },
  ReferenceTerminal = { fg = p.fg, bg = p.bg },
  ReferenceTerminalMode = { fg = p.bar, bg = p.cyan },
  ReferenceTerminalArrow = { fg = p.cyan, bg = p.purple },
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
  String = { fg = p.sage },
  Character = { fg = p.sage },
  Number = { fg = p.pink },
  Boolean = { fg = p.pink },
  Float = { fg = p.pink },
  Identifier = { fg = p.fg },
  Function = { fg = p.fg },
  Statement = { fg = p.red },
  Operator = { fg = p.fg },
  Keyword = { fg = p.red },
  PreProc = { fg = p.sage },
  Type = { fg = p.type },
  StorageClass = { fg = p.type },
  Structure = { fg = p.type },
  Typedef = { fg = p.type },
  Special = { fg = p.pink },
  Delimiter = { fg = p.fg },
  Underlined = { fg = p.type, underline = true },
  Todo = { fg = p.yellow },
  Error = { fg = p.red, bg = p.panel },
  ErrorMsg = { fg = p.red },
  WarningMsg = { fg = p.yellow },
  MoreMsg = { fg = p.sage },
  Question = { fg = p.type },
  ModeMsg = { fg = p.amber, bg = p.bg },
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
  "#1c1c1c", "#b58a8a", "#9da696", "#b9b9b2", "#7da6bd", "#ad929f", "#00bfe8", "#d0d0d0", "#707070", "#c9a1a1", "#b5bdae", "#d0d0c8", "#9fc1d1", "#c3adb8", "#75d8eb", "#e6e6e6"
}
for index, color in ipairs(ansi) do vim.g["terminal_color_" .. (index - 1)] = color end

