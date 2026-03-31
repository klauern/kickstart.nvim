local dap_loaded = false

local function load_dap()
  if dap_loaded then
    return
  end
  dap_loaded = true

  vim.pack.add {
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/jay-babu/mason-nvim-dap.nvim',
    'https://github.com/leoluz/nvim-dap-go',
  }

  local dap = require 'dap'
  local dapui = require 'dapui'

  require('mason-nvim-dap').setup {
    automatic_installation = true,
    handlers = {},
    ensure_installed = {
      'delve',
    },
  }

  dapui.setup {
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  require('dap-go').setup {
    delve = {
      detached = vim.fn.has 'win32' == 0,
    },
  }
end

vim.keymap.set('n', '<F5>', function()
  load_dap()
  require('dap').continue()
end, { desc = 'Debug: Start/Continue' })

vim.keymap.set('n', '<F1>', function()
  load_dap()
  require('dap').step_into()
end, { desc = 'Debug: Step Into' })

vim.keymap.set('n', '<F2>', function()
  load_dap()
  require('dap').step_over()
end, { desc = 'Debug: Step Over' })

vim.keymap.set('n', '<F3>', function()
  load_dap()
  require('dap').step_out()
end, { desc = 'Debug: Step Out' })

vim.keymap.set('n', '<leader>b', function()
  load_dap()
  require('dap').toggle_breakpoint()
end, { desc = 'Debug: Toggle Breakpoint' })

vim.keymap.set('n', '<leader>B', function()
  load_dap()
  require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })

vim.keymap.set('n', '<F7>', function()
  load_dap()
  require('dapui').toggle()
end, { desc = 'Debug: See last session result.' })
