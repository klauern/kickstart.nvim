-- which-key (eager — loaded via vim.pack.add in init.lua)
require('which-key').setup {
  delay = 0,
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },
  spec = {
    { '<leader>a', group = '[A]I', mode = { 'n', 'v' } },
    { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
    { '<leader>d', group = '[D]ocument' },
    { '<leader>r', group = '[R]ename' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>w', group = '[W]orkspace' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { '<leader>x', group = 'Diagnostics' },
  },
}

-- mini.nvim (eager — loaded via vim.pack.add in init.lua)
require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()

local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return '%2l:%-2v'
end

-- indent-blankline (lazy: BufReadPre/BufNewFile)
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  callback = function()
    require('kickstart.plugins').add 'indent'
    require('ibl').setup {}
  end,
})

-- todo-comments (lazy: BufReadPre/BufNewFile)
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  callback = function()
    require('kickstart.plugins').add 'todo'
    require('todo-comments').setup { signs = false }
  end,
})

-- nvim-autopairs (lazy: InsertEnter)
vim.api.nvim_create_autocmd('InsertEnter', {
  once = true,
  callback = function()
    require('kickstart.plugins').add 'autopairs'
    require('nvim-autopairs').setup {}
    local cmp_ok, cmp = pcall(require, 'cmp')
    if cmp_ok then
      cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
    end
  end,
})
