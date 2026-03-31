local loaded = false

local function load_conform()
  if loaded then
    return
  end
  loaded = true

  vim.pack.add({ { src = 'https://github.com/stevearc/conform.nvim' } })

  require('conform').setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports', 'gofumpt' },
      python = { 'ruff_format' },
      terraform = { 'terraform_fmt' },
      yaml = { 'yamlfmt' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
    },
  })
end

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('conform_lazy_load', { clear = true }),
  callback = function()
    load_conform()
  end,
})

vim.keymap.set('', '<leader>f', function()
  load_conform()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = '[F]ormat buffer' })

vim.api.nvim_create_user_command('ConformInfo', function()
  load_conform()
  vim.cmd('ConformInfo')
end, {})
