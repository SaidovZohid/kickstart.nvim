-- Core keymaps
local map = vim.keymap.set

-- Clear highlights on search
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic quickfix (now using trouble.nvim - see lua/plugins/ui.lua for <leader>x* bindings)
map('n', '<leader>q', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Open diagnostic [Q]uickfix list (Trouble)' })

-- Paste without overwriting register
map('x', '<leader>p', '"_dP', { desc = 'Paste without overwriting register' })

-- CodeCompanion
map('n', '<leader>cc', ':CodeCompanion chat<CR>', { desc = 'Open CodeCompanion Chat' })

-- Terminal mode exit
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Neo-tree
map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })
map('n', '<leader>o', '<cmd>Neotree reveal<CR>', { desc = 'Reveal file in Neo-tree' })
map('n', '<leader>O', '<cmd>Neotree close<CR>', { desc = 'Close Neo-tree' })
map('n', '<leader>fe', '<cmd>Neotree focus filesystem left<CR>', { desc = 'Focus Neo-tree (filesystem)' })
map('n', '<leader>fb', '<cmd>Neotree float buffers<CR>', { desc = 'Open Buffers (Neo-tree)' })

-- Buffer management
map('n', '<leader>bD', '<cmd>bufdo bdelete<CR>', { desc = 'Close all buffers' })

-- Bufferline navigation
map('n', 'H', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
map('n', 'L', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
map('n', '<leader>bd', '<Cmd>bdelete<CR>', { desc = 'Close current buffer', silent = true })
map('n', '<leader>bo', function()
  local current = vim.fn.bufnr()
  vim.cmd('bufdo if bufnr("") != ' .. current .. ' | bdelete | endif')
end, { desc = 'Close other buffers', silent = true })
