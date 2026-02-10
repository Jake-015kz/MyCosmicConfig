local user_config = require('cosmic.core.user')
local icons = require('cosmic.utils.icons')
local u = require('cosmic.utils')

-- on_attach для nvim-tree
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  -- подключаем дефолтные маппинги
  api.config.mappings.default_on_attach(bufnr)

  -- l — открыть файл / папку
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))

  -- h — закрыть папку
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
end

-- args
local args = {
  respect_buf_cwd = true,

  on_attach = on_attach,

  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = icons.hint,
      info = icons.info,
      warning = icons.warn,
      error = icons.error,
    },
  },

  update_focused_file = {
    enable = true,
  },

  view = {
    width = 40,
    number = true,
    relativenumber = true,
  },

  git = {
    ignore = true,
  },

  renderer = {
    highlight_git = true,
    special_files = {},
    icons = {
      glyphs = {
        default = '',
        symlink = icons.symlink,
        git = icons.git,
        folder = icons.folder,
      },
    },
  },
}

return {
  'kyazdani42/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup(
      u.merge(args, user_config.plugins.nvim_tree or {})
    )
  end,

  init = function()
    local map = require('cosmic.utils').set_keymap

    map('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle Tree' })
    map('n', '<leader>nt', ':NvimTreeToggle<CR>', { desc = 'Toggle Tree' })
    map('n', '<leader>nr', ':NvimTreeRefresh<CR>', { desc = 'Refresh Tree' })
  end,

  cmd = {
    'NvimTreeClipboard',
    'NvimTreeFindFile',
    'NvimTreeOpen',
    'NvimTreeRefresh',
    'NvimTreeToggle',
  },

  enabled = not vim.tbl_contains(
    user_config.disable_builtin_plugins,
    'nvim-tree'
  ),
}
