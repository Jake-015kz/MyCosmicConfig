local map = require('cosmic.utils').set_keymap
local opts = { noremap = true, silent = true }

-- =============================================================================
-- [1] ФАЙЛОВОЕ ДЕРЕВО (Создание файлов/папок на 'a' внутри дерева)
-- =============================================================================
map('n', '<leader>e', ':NvimTreeToggle<cr>', { desc = 'Explorer' })

-- =============================================================================
-- [2] КОД-РАННЕР (Умный запуск)
-- =============================================================================
local function smart_run()
  vim.cmd('w')
  local ft = vim.bo.filetype
  if ft == 'javascript' or ft == 'typescript' then
    vim.cmd('TermExec cmd="node %"')
  elseif ft == 'python' then
    vim.cmd('TermExec cmd="python3 %"')
  else
    print("No runner for: " .. ft)
  end
end
map('n', '<leader>r', smart_run, { desc = 'Smart Run' }) -- Одна кнопка вместо rj, rp
-- Оставил старые на всякий случай, если привык:
map('n', '<leader>rj', ':w<cr>:TermExec cmd="node %"<cr>', { desc = 'Run JS' })
map('n', '<leader>rp', ':w<cr>:TermExec cmd="python3 %"<cr>', { desc = 'Run Python' })

-- =============================================================================
-- [3] ТЕРМИНАЛЫ
-- =============================================================================
map('n', '<leader>th', '<cmd>ToggleTerm size=15 direction=horizontal<cr>', { desc = 'Terminal Bottom' })
map('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Terminal Float' })

-- Выход из режима терминала
map('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- Бесшовная навигация (из кода в терминал и обратно через Ctrl + hjkl)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
map('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
map('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
map('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)

-- =============================================================================
-- [4] БУФЕРЫ (Вкладки) - Сократил до H и L
-- =============================================================================
map('n', 'L', ':bnext<cr>', { desc = 'Next buffer' })
map('n', 'H', ':bprev<cr>', { desc = 'Prev buffer' })
map('n', '<leader>kd', ':bdelete<cr>', { desc = 'Delete buffer' })
map('n', '<leader>ko', '<cmd>%bd|e#<cr>', { desc = 'Close all but current' })
map('n', '<leader>kc', ':new<cr>', { desc = 'New buffer' })

-- =============================================================================
-- [5] QUICKFIX (Твой оригинал)
-- =============================================================================
map('n', '<leader>ck', ':cexpr []<cr>', { desc = 'Clear list' })
map('n', '<leader>cc', ':cclose <cr>', { desc = 'Close list' })
map('n', '<leader>co', ':copen <cr>', { desc = 'Open list' })
map('n', '<leader>cf', ':cfdo %s/', { desc = 'Search & Replace' })
map('n', '<leader>cp', ':cprev<cr>zz', { desc = 'Prev Item' })
map('n', '<leader>cn', ':cnext<cr>zz', { desc = 'Next Item' })

-- =============================================================================
-- [6] ОКНА (Сплиты и Ресайз)
-- =============================================================================
map('n', '<leader>sv', ':vsplit<cr>', { desc = 'Split Vertical' })
map('n', '<leader>sh', ':split<cr>', { desc = 'Split Horizontal' })
map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- =============================================================================
-- [7] CODEIUM (AI)
-- =============================================================================
map('i', '<A-f>', function() return require('codeium.virtual_text').accept() end,
  { expr = true, silent = true, desc = 'Accept' })
map('i', '<M-]>', function() return require('codeium.virtual_text').cycle_or_complete() end, { expr = true })
map('i', '<M-[>', function() return require('codeium.virtual_text').cycle_or_complete(-1) end, { expr = true })

-- =============================================================================
-- [8] ПЛАГИНЫ (Lazy) И ТАБЫ
-- =============================================================================
map('n', '<leader>p', ':Lazy show<cr>', { desc = 'Lazy' }) -- Сократил до <leader>p
map('n', '<leader>pu', ':Lazy update<cr>', { desc = 'Update' })
map('n', '<leader>tn', ':tabnext<cr>', { desc = 'Next tab' })
map('n', '<leader>tp', ':tabprevious<cr>', { desc = 'Prev tab' })
map('n', '<leader>td', ':tabclose<cr>', { desc = 'Close tab' })
