local M = {}

M.groups = {
  eager = {
    'https://github.com/tpope/vim-sleuth',
    'https://github.com/NoahTheDuke/vim-just',
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/folke/which-key.nvim',
    'https://github.com/echasnovski/mini.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lua/plenary.nvim',
  },
  ai = {
    'https://github.com/olimorris/codecompanion.nvim',
  },
  completion = {
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/L3MON4D3/LuaSnip',
    'https://github.com/saadparwaiz1/cmp_luasnip',
  },
  debug = {
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/jay-babu/mason-nvim-dap.nvim',
    'https://github.com/leoluz/nvim-dap-go',
  },
  indent = {
    'https://github.com/lukas-reineke/indent-blankline.nvim',
  },
  todo = {
    'https://github.com/folke/todo-comments.nvim',
  },
  autopairs = {
    'https://github.com/windwp/nvim-autopairs',
  },
  format = {
    'https://github.com/stevearc/conform.nvim',
  },
  git = {
    'https://github.com/lewis6991/gitsigns.nvim',
  },
  lint = {
    'https://github.com/mfussenegger/nvim-lint',
  },
  lsp = {
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/williamboman/mason-lspconfig.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
    'https://github.com/j-hui/fidget.nvim',
    'https://github.com/b0o/SchemaStore.nvim',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
  },
  lazydev = {
    'https://github.com/folke/lazydev.nvim',
    'https://github.com/Bilal2453/luvit-meta',
  },
  flash = {
    'https://github.com/folke/flash.nvim',
  },
  neotree = {
    'https://github.com/nvim-neo-tree/neo-tree.nvim',
    'https://github.com/MunifTanjim/nui.nvim',
  },
  oil = {
    'https://github.com/stevearc/oil.nvim',
  },
  trouble = {
    'https://github.com/folke/trouble.nvim',
  },
  telescope = {
    { src = 'https://github.com/nvim-telescope/telescope.nvim', version = '0.1.x' },
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  },
}

function M.add(group)
  local specs = assert(M.groups[group], 'unknown plugin group: ' .. group)
  vim.pack.add(specs)
end

function M.all()
  local specs = {}
  local seen = {}
  for _, group in pairs(M.groups) do
    for _, spec in ipairs(group) do
      local src = type(spec) == 'table' and spec.src or spec
      if not seen[src] then
        seen[src] = true
        table.insert(specs, spec)
      end
    end
  end
  return specs
end

function M.update(opts)
  -- Register every plugin without loading it so rarely used plugins are also
  -- installed, locked, and included in vim.pack.update(). Restart afterwards.
  vim.pack.add(M.all(), { confirm = false, load = false })
  vim.pack.update(nil, opts or {})
end

return M
