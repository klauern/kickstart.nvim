-- Flash
local flash_loaded = false
local function load_flash()
  if flash_loaded then
    return
  end
  flash_loaded = true
  require('kickstart.plugins').add 'flash'
  require('flash').setup {}
end

vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  load_flash()
  require('flash').jump()
end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
  load_flash()
  require('flash').treesitter()
end, { desc = 'Flash Treesitter' })
vim.keymap.set('o', 'r', function()
  load_flash()
  require('flash').remote()
end, { desc = 'Remote Flash' })
vim.keymap.set({ 'o', 'x' }, 'R', function()
  load_flash()
  require('flash').treesitter_search()
end, { desc = 'Treesitter Search' })

-- Neo-tree
local neotree_loaded = false
local function load_neotree()
  if neotree_loaded then
    return
  end
  neotree_loaded = true
  require('kickstart.plugins').add 'neotree'
  require('neo-tree').setup {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_hidden = false,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  }
end

vim.keymap.set('n', '\\', function()
  load_neotree()
  vim.cmd 'Neotree reveal'
end, { desc = 'NeoTree reveal', silent = true })

-- Oil
local oil_loaded = false
local function load_oil()
  if oil_loaded then
    return
  end
  oil_loaded = true
  require('kickstart.plugins').add 'oil'
  require('oil').setup {
    default_file_explorer = false,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['q'] = 'actions.close',
    },
  }
  vim.cmd 'Oil'
end

vim.keymap.set('n', '-', function()
  load_oil()
end, { desc = 'Open parent directory (Oil)' })

-- Trouble
local trouble_loaded = false
local function load_trouble(cmd)
  if not trouble_loaded then
    trouble_loaded = true
    require('kickstart.plugins').add 'trouble'
    require('trouble').setup {}
  end
  vim.cmd(cmd)
end

vim.keymap.set('n', '<leader>xx', function()
  load_trouble 'Trouble diagnostics toggle'
end, { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', function()
  load_trouble 'Trouble diagnostics toggle filter.buf=0'
end, { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', function()
  load_trouble 'Trouble symbols toggle focus=false'
end, { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', function()
  load_trouble 'Trouble lsp toggle focus=false win.position=right'
end, { desc = 'LSP Definitions / references (Trouble)' })
vim.keymap.set('n', '<leader>xL', function()
  load_trouble 'Trouble loclist toggle'
end, { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', function()
  load_trouble 'Trouble qflist toggle'
end, { desc = 'Quickfix List (Trouble)' })
