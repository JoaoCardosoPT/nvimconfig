-- Muted palette matched to the reference screenshot (background sampled: #1a1b26).
vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "screenshot-muted"

local p = {
  bg = "#1a1b26", fg = "#c0c0d0", panel = "#181923", line = "#242634",
  selection = "#303348", comment = "#60657f", muted = "#686d87",
  pink = "#c4778b", green = "#afc18c", yellow = "#c6b28b",
  cyan = "#71b8bc", purple = "#a99bc7", orange = "#c6b28b",
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
  Cursor = { fg = p.bg, bg = "#c0c0d0" },
  CursorLine = { bg = p.line },
  CursorColumn = { bg = p.line },
  ColorColumn = { bg = p.line },
  LineNr = { fg = "#414458" },
  CursorLineNr = { fg = "#414458" },
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
  Directory = { fg = "#71b8bc" },
  Title = { fg = p.green, bold = true },
  Comment = { fg = p.comment, italic = true },
  Constant = { fg = p.purple },
  String = { fg = p.green },
  Character = { fg = p.green },
  Number = { fg = p.purple },
  Boolean = { fg = "#91c0d5" },
  Float = { fg = p.purple },
  Identifier = { fg = p.fg },
  Function = { fg = "#8f9dd0" },
  Statement = { fg = p.purple, italic = true },
  Operator = { fg = p.fg },
  Keyword = { fg = p.purple, italic = true },
  PreProc = { fg = "#91c0d5" },
  Type = { fg = "#71b8bc" },
  StorageClass = { fg = p.purple, italic = true },
  Structure = { fg = p.purple, italic = true },
  Typedef = { fg = p.purple, italic = true },
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
  ["@variable.parameter"] = { fg = p.yellow },
  ["@variable.builtin"] = { fg = p.fg },
  ["@property"] = { fg = "#90c8cc" },
  ["@tag"] = { fg = p.pink },
  ["@tag.attribute"] = { fg = p.green },
  ["@markup.heading"] = { fg = p.green, bold = true },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  NvimTreeNormal = { fg = p.fg, bg = p.bg },
  NvimTreeFolderName = { fg = "#71b8bc" },
  NvimTreeOpenedFolderName = { fg = "#71b8bc" },
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
  "#1a1b26", "#c4778b", "#afc18c", "#c6b28b", "#8f9dd0", "#a99bc7", "#71b8bc", "#c0c0d0", "#414458", "#d88fa1", "#c0d09e", "#d9c59e", "#a4b3e5", "#bdaedc", "#90c8cc", "#dedee8"
}
for index, color in ipairs(ansi) do vim.g["terminal_color_" .. (index - 1)] = color end

-- File-browser colors matching the reference.
hi("netrwDir", { fg = "#71b8bc" })
hi("netrwClassify", { fg = "#c6b28b" })
hi("netrwTreeBar", { fg = "#71b8bc" })
hi("netrwPlain", { fg = "#c0c0d0" })
hi("NvimTreeFolderIcon", { fg = "#c6b28b" })
hi("NvimTreeIndentMarker", { fg = "#71b8bc" })

-- Vim's standard C syntax leaves function calls uncolored.
local function c_functions()
  vim.cmd([[syntax match ScreenshotFunction /\<\h\w*\ze\s*(/ contains=cStatement,cConditional,cRepeat,cOperator,cType,cStorageClass]])
end
local group = vim.api.nvim_create_augroup("ScreenshotMutedSyntax", { clear = true })
vim.api.nvim_create_autocmd("Syntax", { group = group, pattern = { "c", "cpp" }, callback = c_functions })
if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then c_functions() end
hi("ScreenshotFunction", { link = "Function" })

-- Python built-ins and booleans are teal in the reference.
hi("pythonBuiltin", { fg = p.cyan, bold = true })
hi("pythonBoolean", { fg = p.cyan, bold = true })
hi("pythonException", { fg = p.fg })
hi("pythonExceptions", { fg = p.fg })
hi("pythonFunction", { fg = p.fg })

-- Explicit captures preserve the reference colors with Treesitter enabled.
hi("@keyword.directive", { link = "PreProc" })
hi("@keyword.directive.define", { link = "PreProc" })
hi("@keyword.type", { link = "Structure" })
hi("@keyword.modifier", { link = "StorageClass" })
hi("@variable.member", { link = "@property" })
hi("@type.builtin", { link = "Type" })
hi("pythonFunction", { link = "Function" })
