-- Charcoal and muted yellow-green palette matched to the supplied screenshot.
vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "screenshot-dark"

local p = {
  bg = "#2d2d2d", fg = "#d8d5be", panel = "#292929", line = "#393939",
  selection = "#454545", comment = "#85817b", muted = "#a19e91",
  pink = "#cc6655", green = "#c3c64a", yellow = "#c3c64a",
  cyan = "#8ca6a0", purple = "#b58a9b", orange = "#cf9857",
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
  Cursor = { fg = p.bg, bg = "#d8d5be" },
  CursorLine = { bg = p.line },
  CursorColumn = { bg = p.line },
  ColorColumn = { bg = p.line },
  LineNr = { fg = p.comment },
  CursorLineNr = { fg = p.fg },
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
  Directory = { fg = "#a8b989" },
  Title = { fg = p.green, bold = true },
  Comment = { fg = p.comment },
  Constant = { fg = p.fg },
  String = { fg = p.yellow },
  Character = { fg = p.yellow },
  Number = { fg = p.purple },
  Boolean = { fg = p.purple },
  Float = { fg = p.purple },
  Identifier = { fg = p.fg },
  Function = { fg = p.green, bold = true },
  Statement = { fg = p.pink },
  Operator = { fg = p.fg },
  Keyword = { fg = p.pink },
  PreProc = { fg = p.pink },
  Type = { fg = "#d7c66f" },
  StorageClass = { fg = p.pink },
  Structure = { fg = "#d7c66f" },
  Typedef = { fg = "#d7c66f" },
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
  ["@variable.parameter"] = { fg = p.orange, italic = true },
  ["@variable.builtin"] = { fg = p.cyan, italic = true },
  ["@property"] = { fg = p.fg },
  ["@tag"] = { fg = p.pink },
  ["@tag.attribute"] = { fg = p.green },
  ["@markup.heading"] = { fg = p.green, bold = true },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  NvimTreeNormal = { fg = p.fg, bg = p.bg },
  NvimTreeFolderName = { fg = "#a8b989" },
  NvimTreeOpenedFolderName = { fg = "#a8b989" },
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
  p.bg, p.pink, p.green, p.yellow, p.cyan, p.purple, "#a8b989", p.fg,
  p.comment, p.pink, p.green, p.yellow, p.cyan, p.purple, "#a8b989", "#ebe6d2",
}
for index, color in ipairs(ansi) do vim.g["terminal_color_" .. (index - 1)] = color end

-- File-browser colors matching the reference.
hi("netrwDir", { fg = "#a8b989" })
hi("netrwClassify", { fg = "#cf9857" })
hi("netrwTreeBar", { fg = "#85817b" })
hi("netrwPlain", { fg = "#d8d5be" })
hi("NvimTreeFolderIcon", { fg = "#cf9857" })
hi("NvimTreeIndentMarker", { fg = "#85817b" })

-- Vim's standard C syntax leaves function calls uncolored.
local function c_functions()
  vim.cmd([[syntax match ScreenshotFunction /\<\h\w*\ze\s*(/ contains=cStatement,cConditional,cRepeat,cOperator,cType,cStorageClass]])
end
local group = vim.api.nvim_create_augroup("ScreenshotDarkSyntax", { clear = true })
vim.api.nvim_create_autocmd("Syntax", { group = group, pattern = { "c", "cpp" }, callback = c_functions })
if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then c_functions() end
hi("ScreenshotFunction", { link = "Function" })
