-- Autocommands

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Language-specific indentation settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'html', 'json' },
  callback = function()
    vim.opt_local.expandtab = false -- Use tabs, not spaces
    vim.opt_local.tabstop = 4 -- 1 tab = 4 spaces visually
    vim.opt_local.shiftwidth = 4 -- >> indent uses 4 spaces
    vim.opt_local.softtabstop = 4 -- <Tab> inserts 1 tab, shown as 4 spaces
  end,
})

-- Quickfix list keymap
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf' },
  callback = function()
    vim.keymap.set('n', 'q', ':q<CR>', { buffer = true, silent = true })
  end,
})

-- Spectre panel keymap
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'spectre_panel',
  callback = function(args)
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = args.buf, silent = true, desc = 'Close Spectre panel' })
  end,
})

-- Alpha dashboard - disable folding
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'alpha',
  callback = function()
    vim.opt_local.foldenable = false
  end,
})
