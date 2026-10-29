-- Cool, muted palette matched to the C-code reference screenshot.
vim.o.background = "dark"
vim.cmd("highlight clear")
vim.g.colors_name = "screenshot-lavender"

local p = {
  bg = "#1b1b26", fg = "#b8b9ce", muted = "#56596c",
  sage = "#9e91c5", pink = "#a397c9", type = "#56b6c2",
  panel = "#20202d", bar = "#232332", inactive = "#1b1b26",
  selection = "#36364b", yellow = "#c0a97a", red = "#cc8793",
}

local function hi(name, value) vim.api.nvim_set_hl(0, name, value) end
local groups = {
  Normal = { fg = p.fg, bg = p.bg },
  NormalNC = { fg = p.fg, bg = p.bg },
  NormalFloat = { fg = p.fg, bg = p.panel },
  FloatBorder = { fg = p.muted, bg = p.panel },
  FloatTitle = { fg = p.type, bg = p.panel },
  Cursor = { fg = p.bg, bg = "#ffffff" },
  CursorLine = { bg = p.panel },
  CursorColumn = { bg = p.panel },
  ColorColumn = { bg = p.panel },
  LineNr = { fg = "#3d4052", bg = p.bg },
  CursorLineNr = { fg = "#3d4052", bg = p.bg },
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
  String = { fg = "#a6b88a" },
  Character = { fg = "#a6b88a" },
  Number = { fg = "#d09b79" },
  Boolean = { fg = "#8fbbd0" },
  Float = { fg = "#d09b79" },
  Identifier = { fg = p.fg },
  Function = { fg = "#8e9dce" },
  Statement = { fg = p.sage },
  Operator = { fg = p.fg },
  Keyword = { fg = p.sage },
  PreProc = { fg = p.sage },
  Type = { fg = p.type },
  StorageClass = { fg = p.sage },
  Structure = { fg = p.sage },
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

-- Semantic captures preserve the reference's gold arguments and teal members.
hi("@variable.parameter", { fg = p.yellow })
hi("@lsp.type.parameter", { link = "@variable.parameter" })
hi("@variable.member", { fg = "#80bfc5" })
hi("@property", { link = "@variable.member" })
hi("@lsp.type.property", { link = "@variable.member" })
hi("@keyword.return", { fg = p.pink, italic = true })
hi("ReferenceTerminal", { fg = p.fg, bg = p.bg })
hi("ReferenceTerminalMode", { fg = p.bg, bg = "#8e9dce", bold = true })
hi("ReferenceTerminalArrow", { fg = "#8e9dce", bg = p.bar })
local ansi = {
  "#171720", "#cc8793", "#a6b88a", "#c0a97a", "#8e9dce", "#a397c9", "#56b6c2", "#b8b9ce",
  "#56596c", "#df98a3", "#b8c99b", "#d4bc8e", "#a3b1df", "#b9abdf", "#86d5d9", "#d3d4e5",
}
for index, color in ipairs(ansi) do vim.g["terminal_color_" .. (index - 1)] = color end
