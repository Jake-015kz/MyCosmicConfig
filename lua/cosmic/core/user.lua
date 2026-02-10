-- DEFAULT USER SETTINGS
local ok, user_config = pcall(require, 'cosmic.config.config')

if not ok then
  user_config = {}
end

local default_config = {
  border = 'rounded',
  disable_builtin_plugins = {},
  add_plugins = {},
  plugins = {},
  lsp = {
    inlay_hint = false,
    format_timeout = 500,
    rename_notification = true,
    -- table of callbacks pushed via plugins
    on_attach_mappings = {},
    -- lsp servers that should be installed
    ensure_installed = {
      'astro',
      'cssls',
      'somesass_ls',
      'eslint',
      'gopls',
      'graphql',
      'html',
      'jsonls',
      'lua_ls',
      'pyright',
      'svelte',
      'tailwindcss',
      'ts_ls',
      'yamlls',
    },
    -- lsp servers that should be enabled
    servers = {
      astro = true,
      tailwindcss = true,
      eslint = true,
      jsonls = {
        format_on_save = false,
      },
      pyright = true,
      lua_ls = {
        format_on_save = false,
      },
      gopls = true,
      html = true,
      ts_ls = {
        format_on_save = false,
      },
    },
  },
}

local u = require('cosmic.utils')
local config = u.merge(default_config, user_config)

function config.lsp.add_on_attach_mapping(callback)
  table.insert(config.lsp.on_attach_mappings, callback)
end

-- Добавляем описание группы клавиш для удобства
local ok_wk, wk = pcall(require, 'which-key')
if ok_wk then
  wk.add({
    { "<leader>w", group = "Windsurf AI" },
  })
end

-- Автосохранение при выходе из режима вставки или изменении текста
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = { "*.js", "*.scss", "*.html", "*.css", "*.jsx", ".*tsx" },
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! wall")
    end
  end,
})
return config
