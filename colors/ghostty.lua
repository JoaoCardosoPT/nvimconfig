-- Reference-matched classic palette, shared with the Ghostty configuration.
vim.o.background = "dark"
vim.cmd("highlight clear")
vim.g.colors_name = "ghostty"

local p = {
  bg = "#080808", fg = "#b0b0b0", muted = "#626262", comment = "#4f8f8f",
  panel = "#121212", line = "#181818", selection = "#6ca6ce",
  red = "#a06060", yellow = "#a6a04a", blue = "#6ca6ce",
  purple = "#967494", cyan = "#4f8f8f", green = "#4f8a48", ochre = "#907340",
}

local function hi(name, value)
  vim.api.nvim_set_hl(0, name, value)
end

local groups = {
  -- Inherit Ghostty's solid #080808 background in the editor and file tree.
  Normal = { fg = p.fg, bg = "NONE" },
  NormalNC = { fg = p.fg, bg = "NONE" },
  NormalFloat = { fg = p.fg, bg = p.panel },
  FloatBorder = { fg = p.muted, bg = p.panel },
  FloatTitle = { fg = p.fg, bg = p.panel, bold = true },
  Cursor = { fg = p.bg, bg = "#dadbd9" },
  CursorLine = { bg = p.line },
  CursorColumn = { bg = p.line },
  ColorColumn = { bg = p.line },
  LineNr = { fg = "#ffffff" },
  CursorLineNr = { fg = "#ffffff" },
  SignColumn = { bg = "NONE" },
  EndOfBuffer = { fg = p.bg, bg = "NONE" },
  NonText = { fg = p.muted },
  Whitespace = { fg = p.line },
  Visual = { fg = "#dadbd9", bg = p.selection },
  Search = { fg = "#dadbd9", bg = p.selection },
  IncSearch = { fg = "#dadbd9", bg = p.selection },
  CurSearch = { fg = "#dadbd9", bg = p.selection },
  MatchParen = { fg = p.fg, bg = p.selection, bold = true },
  StatusLine = { fg = p.fg, bg = p.line },
  StatusLineNC = { fg = p.comment, bg = "NONE" },
  WinSeparator = { fg = "#dadbd9", bg = "NONE" },
  TabLine = { fg = p.comment, bg = "NONE" },
  TabLineFill = { bg = "NONE" },
  TabLineSel = { fg = p.bg, bg = p.fg, bold = true },
  Pmenu = { fg = p.fg, bg = p.panel },
  PmenuSel = { fg = p.fg, bg = p.selection },
  PmenuSbar = { bg = p.line },
  PmenuThumb = { bg = p.muted },
  Folded = { fg = p.comment, bg = p.line },
  FoldColumn = { fg = p.muted, bg = "NONE" },
  Directory = { fg = p.cyan },
  Title = { fg = p.fg, bold = true },
  Comment = { fg = p.comment },
  Constant = { fg = p.fg },
  String = { fg = p.ochre },
  Character = { fg = p.ochre },
  Number = { fg = p.ochre },
  Boolean = { fg = p.ochre },
  Float = { fg = p.ochre },
  Identifier = { fg = p.fg },
  Function = { fg = p.fg },
  Statement = { fg = p.yellow },
  Operator = { fg = p.fg },
  Keyword = { fg = p.yellow },
  PreProc = { fg = p.yellow },
  Type = { fg = p.green },
  StorageClass = { fg = p.green },
  Structure = { fg = p.green },
  Typedef = { fg = p.green },
  Special = { fg = p.yellow },
  Delimiter = { fg = p.fg },
  Underlined = { fg = p.blue, underline = true },
  Todo = { fg = p.yellow, bold = true },
  Error = { fg = p.red },
  ErrorMsg = { fg = p.red },
  WarningMsg = { fg = p.yellow },
  MoreMsg = { fg = p.fg },
  Question = { fg = p.cyan },
  ModeMsg = { fg = p.fg },
  DiffAdd = { bg = "#202a25" },
  DiffChange = { bg = "#202830" },
  DiffDelete = { fg = p.red, bg = "#302020" },
  DiffText = { bg = "#304050" },
  TelescopeNormal = { fg = p.fg, bg = p.panel },
  TelescopeBorder = { fg = p.muted, bg = p.panel },
  TelescopeSelection = { bg = p.selection },
  TelescopeMatching = { fg = p.blue, bold = true },
  NvimTreeCursorLine = { underline = true, sp = "#dadbd9" },
}
for name, value in pairs(groups) do hi(name, value) end

local links = {
  TermCursor = "Cursor", lCursor = "Cursor",
  ["@variable"] = "Identifier", ["@variable.parameter"] = "Identifier",
  ["@variable.member"] = "Identifier", ["@variable.builtin"] = "Identifier",
  ["@property"] = "Identifier", ["@module"] = "Identifier",
  ["@function"] = "Function", ["@function.builtin"] = "Function",
  ["@function.call"] = "Function", ["@function.method"] = "Function",
  ["@function.method.call"] = "Function", ["@function.macro"] = "PreProc",
  ["@constructor"] = "Type", ["@type"] = "Type", ["@type.builtin"] = "Type",
  ["@keyword"] = "Keyword", ["@keyword.import"] = "PreProc",
  ["@keyword.operator"] = "Keyword",
  ["@keyword.storage"] = "StorageClass", ["@keyword.type"] = "Structure",
  ["@operator"] = "Operator", ["@constant"] = "Constant",
  ["@constant.builtin"] = "Boolean", ["@string"] = "String",
  ["@string.escape"] = "Special", ["@string.regexp"] = "String",
  ["@character"] = "Character", ["@number"] = "Number",
  ["@boolean"] = "Boolean", ["@comment"] = "Comment",
  ["@punctuation"] = "Delimiter", ["@label"] = "Statement",
  ["@tag"] = "Type", ["@tag.attribute"] = "Identifier",
  ["@tag.delimiter"] = "Delimiter", ["@markup.heading"] = "Title",
  ["@lsp.type.variable"] = "Identifier", ["@lsp.type.parameter"] = "Identifier",
  ["@lsp.type.property"] = "Identifier", ["@lsp.type.function"] = "Function",
  ["@lsp.type.method"] = "Function", ["@lsp.type.class"] = "Type",
  ["@lsp.type.struct"] = "Type", ["@lsp.type.enum"] = "Type",
  ["@lsp.type.enumMember"] = "Constant", ["@lsp.type.namespace"] = "Identifier",
  ["@lsp.type.macro"] = "PreProc", ["@lsp.type.decorator"] = "PreProc",
  NvimTreeNormal = "Normal", NvimTreeNormalNC = "NormalNC",
  NvimTreeNormalFloat = "NormalFloat", NvimTreeEndOfBuffer = "EndOfBuffer",
  NvimTreeWinSeparator = "WinSeparator", NvimTreeRootFolder = "Directory",
  NvimTreeFolderName = "Directory", NvimTreeOpenedFolderName = "Directory",
  NvimTreeEmptyFolderName = "Directory", NvimTreeFolderIcon = "Directory",
  NvimTreeFolderArrowClosed = "Directory", NvimTreeFolderArrowOpen = "Directory",
  NvimTreeIndentMarker = "NonText", NvimTreeSpecialFile = "Normal",
  NvimTreeGitIgnoredHL = "Comment", NvimTreeGitDirtyIcon = "WarningMsg",
  NvimTreeGitNewIcon = "Directory", NvimTreeGitStagedIcon = "Normal",
  netrwDir = "Directory", netrwClassify = "Delimiter", netrwPlain = "Normal",
}
for name, target in pairs(links) do hi(name, { link = target }) end
for severity, color in pairs({ Error = p.red, Warn = p.yellow, Info = p.blue, Hint = p.cyan }) do
  hi("Diagnostic" .. severity, { fg = color })
  hi("DiagnosticUnderline" .. severity, { sp = color, undercurl = true })
end
for name, color in pairs({ Add = p.fg, Change = p.yellow, Delete = p.red }) do
  hi("GitSigns" .. name, { fg = color })
end

-- The built-in terminal uses the same 16 colors as Ghostty.
local ansi = {
  "#080808", "#a06060", "#4f8a48", "#a6a04a", "#6ca6ce", "#967494", "#4f8f8f", "#b0b0b0",
  "#626262", "#bc7777", "#69a763", "#bcb65c", "#86b8dc", "#ab8aaa", "#65a6a6", "#dadbd9",
}
for index, color in ipairs(ansi) do vim.g["terminal_color_" .. (index - 1)] = color end
