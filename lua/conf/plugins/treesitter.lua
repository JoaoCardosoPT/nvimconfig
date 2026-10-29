return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    treesitter.setup({})
    treesitter.install({
      "bash", "c", "cmake", "cpp", "css", "diff", "html",
      "javascript", "jsdoc", "json", "lua", "luadoc",
      "markdown", "markdown_inline", "matlab", "python", "query",
      "rust", "go", "gomod", "regex", "toml", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml",
    })

    local group = vim.api.nvim_create_augroup("TreesitterFeatures", { clear = true })
    vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
      group = group,
      callback = function(event)
        local buf = event.buf
        if vim.bo[buf].buftype ~= "" then return end

        -- Keep large/generated files responsive, including bundled ftplugins.
        local lines = vim.api.nvim_buf_line_count(buf)
        if lines > 20000 or vim.api.nvim_buf_get_offset(buf, lines) > 1024 * 1024 then
          vim.treesitter.stop(buf)
          return
        end

        local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
        if not lang or not pcall(vim.treesitter.start, buf, lang) then return end

        -- Python's built-in indentation is more predictable for editing blocks.
        if lang ~= "python" and vim.treesitter.query.get(lang, "indents") then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
        if vim.treesitter.query.get(lang, "folds") then
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldlevel = 99 -- Start unfolded; za/zc/zo control folds.
        end
      end,
    })
  end,
}
