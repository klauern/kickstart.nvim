local codecompanion_loaded = false

local function load_codecompanion()
  if codecompanion_loaded then
    return
  end
  codecompanion_loaded = true

  require('kickstart.plugins').add 'ai'

  require('codecompanion').setup {
    strategies = {
      chat = { adapter = 'gateway' },
      inline = { adapter = 'gateway' },
    },
    adapters = {
      http = {
        gateway = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              api_key = 'OPENAI_API_KEY',
              url = 'https://ai-gateway.zende.sk',
              chat_url = '/v1/chat/completions',
              models_endpoint = '/v1/models',
            },
            schema = {
              model = {
                default = 'claude-sonnet-4-20250514',
              },
            },
          })
        end,
      },
    },
  }
end

vim.keymap.set({ 'n', 'v' }, '<leader>ac', function()
  load_codecompanion()
  vim.cmd 'CodeCompanionChat Toggle'
end, { noremap = true, desc = 'AI Chat toggle' })

vim.keymap.set({ 'n', 'v' }, '<leader>aa', function()
  load_codecompanion()
  vim.cmd 'CodeCompanionActions'
end, { noremap = true, desc = 'AI Actions' })

vim.keymap.set('v', '<leader>ai', function()
  load_codecompanion()
  vim.cmd 'CodeCompanion'
end, { noremap = true, desc = 'AI Inline (selection)' })
