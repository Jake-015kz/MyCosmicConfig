local user_config = require('cosmic.core.user')
local u = require('cosmic.utils')

return {
  'hrsh7th/nvim-cmp',
  config = function()
    -- Сначала загружаем стандартный конфиг Cosmic
    require('cosmic.plugins.nvim-cmp.config')

    -- А теперь поверх добавляем наш серый текст
    local cmp = require('cmp')
    cmp.setup({
      experimental = {
        ghost_text = true,
      },
      -- Если хочешь, чтобы Enter сразу подтверждал (как в VS Code), добавь это:
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
    })
  end,
  dependencies = {
    -- ... (все твои зависимости остаются без изменений)
    'hrsh7th/cmp-nvim-lsp',
    {
      'saadparwaiz1/cmp_luasnip',
      enabled = not vim.tbl_contains(user_config.disable_builtin_plugins, 'luasnip'),
    },
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    {
      'L3MON4D3/LuaSnip',
      config = function()
        local ls = require('luasnip')
        ls.config.set_config(u.merge({
          history = true,
          updateevents = 'TextChanged,TextChangedI',
          enable_autosnippets = true,
        }, user_config.plugins.luasnip or {}))

        require('luasnip').filetype_extend('javascriptreact', { 'html' })
        require('luasnip').filetype_extend('typescriptreact', { 'html' })

        require('luasnip.loaders.from_vscode').lazy_load()
      end,
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
      enabled = not vim.tbl_contains(user_config.disable_builtin_plugins, 'luasnip'),
    },
  },
  event = 'InsertEnter',
  enabled = not vim.tbl_contains(user_config.disable_builtin_plugins, 'nvim-cmp'),
}
