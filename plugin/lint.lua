vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  callback = function()
    vim.pack.add({ { src = 'https://github.com/mfussenegger/nvim-lint' } })

    local lint = require 'lint'
    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      go = { 'golangcilint' },
      python = { 'ruff' },
      terraform = { 'tflint' },
      yaml = { 'yamllint' },
      dockerfile = { 'hadolint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end,
    })

    lint.try_lint()
  end,
})
