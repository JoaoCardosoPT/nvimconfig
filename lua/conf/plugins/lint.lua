return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    local lint = require("lint")
    local web = { javascript = true, javascriptreact = true, typescript = true, typescriptreact = true }

    local function run()
      local buf = vim.api.nvim_get_current_buf()
      local file = vim.api.nvim_buf_get_name(buf)
      if vim.bo[buf].buftype ~= "" or file == "" then return end
      local dir = vim.fs.dirname(file)
      if vim.bo[buf].filetype == "python" then
        local root = vim.fs.root(buf, { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" }) or dir
        local local_ruff = root .. "/.venv/bin/ruff"
        local command = vim.fn.executable(local_ruff) == 1 and local_ruff or "ruff"
        if vim.fn.executable(command) == 1 then
          lint.try_lint("ruff", {
            cwd = root,
            wrap_linter = function(linter) linter.cmd = command; return linter end,
          })
        end
      elseif web[vim.bo[buf].filetype] and not vim.bo[buf].modified then
        -- Use the project's own linter/version, including hoisted monorepo tools.
        -- Oxlint reads the saved file, so don't lint stale disk content while typing.
        local root = dir
        while root do
          for _, name in ipairs({ "oxlint", "eslint" }) do
            local command = root .. "/node_modules/.bin/" .. name
            if vim.fn.executable(command) == 1 then
              lint.try_lint(name, {
                cwd = vim.fs.root(buf, "package.json") or root,
                wrap_linter = function(linter) linter.cmd = command; return linter end,
              })
              return
            end
          end
          local parent = vim.fs.dirname(root)
          if parent == root then break end
          root = parent
        end
      end
    end

    local group = vim.api.nvim_create_augroup("ProjectLint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = group,
      callback = run,
    })
    vim.keymap.set("n", "<leader>cl", run, { desc = "Lint current file" })
  end,
}
