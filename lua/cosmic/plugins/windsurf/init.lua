return {
  'Exafunction/windsurf.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local ok, codeium = pcall(require, 'codeium')
    if ok then
      codeium.setup({
        virtual_text = {
          enabled = true,
          map_keys = true,
          key_bindings = {
            accept = "<Tab>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        }
      })
    end

    -- Бинды
    vim.keymap.set('n', '<leader>wa', '<cmd>Codeium Auth<cr>', { desc = 'Windsurf Auth' })
    vim.keymap.set('n', '<leader>wc', '<cmd>Codeium Chat<cr>', { desc = 'Windsurf Chat' })
  end,
}
