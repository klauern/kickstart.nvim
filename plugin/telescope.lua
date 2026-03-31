local loaded = false

local function load_telescope()
  if loaded then
    return
  end
  loaded = true

  vim.pack.add({
    { src = 'https://github.com/nvim-telescope/telescope.nvim', version = '0.1.x' },
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  })

  require('telescope').setup {
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  }

  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')
end

local function tmap(lhs, builtin_fn, desc, opts)
  vim.keymap.set('n', lhs, function()
    load_telescope()
    require('telescope.builtin')[builtin_fn](opts)
  end, { desc = desc })
end

tmap('<leader>sh', 'help_tags', '[S]earch [H]elp')
tmap('<leader>sk', 'keymaps', '[S]earch [K]eymaps')
tmap('<leader>sf', 'find_files', '[S]earch [F]iles')
tmap('<leader>ss', 'builtin', '[S]earch [S]elect Telescope')
tmap('<leader>sw', 'grep_string', '[S]earch current [W]ord')
tmap('<leader>sg', 'live_grep', '[S]earch by [G]rep')
tmap('<leader>sd', 'diagnostics', '[S]earch [D]iagnostics')
tmap('<leader>sr', 'resume', '[S]earch [R]esume')
tmap('<leader>s.', 'oldfiles', '[S]earch Recent Files ("." for repeat)')
tmap('<leader><leader>', 'buffers', '[ ] Find existing buffers')

vim.keymap.set('n', '<leader>/', function()
  load_telescope()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
  load_telescope()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>sn', function()
  load_telescope()
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
