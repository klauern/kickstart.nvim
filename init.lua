-- Leader key (must be set before plugins load)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- [[ Options ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- [[ Filetype detection ]]
-- Register filetypes that LSP servers expect but Neovim doesn't detect natively
vim.filetype.add {
  filename = {
    ['go.work'] = 'gowork',
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['compose.yaml'] = 'yaml.docker-compose',
    ['.gitlab-ci.yml'] = 'yaml.gitlab',
    ['Taskfile.yml'] = 'yaml',
    ['Taskfile.yaml'] = 'yaml',
    ['justfile'] = 'just',
    ['Justfile'] = 'just',
    ['.justfile'] = 'just',
  },
  pattern = {
    ['.*%.tmpl'] = 'gotmpl',
    ['.*%.gotmpl'] = 'gotmpl',
    ['.*%.tfvars'] = 'terraform-vars',
    ['.*values%.ya?ml'] = 'yaml.helm-values',
  },
}

-- [[ Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Split navigation with CTRL+hjkl
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Bytecode cache (replaces lazy.nvim's loader) ]]
vim.loader.enable()

-- [[ Eager plugins — must load before plugin/ files ]]
require('kickstart.plugins').add 'eager'

-- [[ Build hooks for all plugins ]]
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local path = vim.fn.stdpath 'data' .. '/pack/core/opt/' .. name
    if name == 'telescope-fzf-native.nvim' then
      vim.fn.system { 'make', '-C', path }
    elseif name == 'LuaSnip' and vim.fn.executable 'make' == 1 then
      vim.fn.system { 'make', 'install_jsregexp', '-C', path }
    end
  end,
})

vim.api.nvim_create_user_command('PackUpdate', function(opts)
  require('kickstart.plugins').update { force = opts.bang }
end, {
  bang = true,
  desc = 'Install and update all plugins (use ! to skip confirmation)',
})

-- vim: ts=2 sts=2 sw=2 et
