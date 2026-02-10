local user_config = require('cosmic.core.user')
local u = require('cosmic.utils')

local defaults = {
  ensure_installed = {
    'astro', 'css', 'html', 'javascript', 'json', 'lua',
    'markdown', 'markdown_inline', 'scss', 'typescript', 'tsx', 'yaml',
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  -- УДАЛИЛИ БЛОК REFACTOR ОТСЮДА
}

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'windwp/nvim-ts-autotag',
    'JoosepAlviste/nvim-ts-context-commentstring',
    -- УДАЛИЛИ 'nvim-treesitter/nvim-treesitter-refactor' ОТСЮДА
  },
  event = 'BufEnter',
  build = ':TSUpdate',
  config = function()
    -- Используем новый способ вызова, если старый не найден
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      configs.setup(u.merge(defaults, user_config.plugins.treesitter or {}))
    else
      -- Если не нашли configs, пробуем запустить напрямую через основной модуль
      require("nvim-treesitter").setup(u.merge(defaults, user_config.plugins.treesitter or {}))
    end
  end,
  enabled = not vim.tbl_contains(user_config.disable_builtin_plugins, 'treesitter'),
}
