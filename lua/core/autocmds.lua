-- Autocommands

-- Filetype detection for templ files
vim.filetype.add {
  extension = {
    templ = 'templ',
  },
}

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Language-specific indentation settings
local indent_group = vim.api.nvim_create_augroup('custom-indentation', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'templ',
  callback = function()
    -- Go-style comments work perfectly in templ
    vim.bo.commentstring = '// %s'
  end,
})

-- -- Languages that use tabs
-- vim.api.nvim_create_autocmd('FileType', {
--   group = indent_group,
--   pattern = { 'go', 'templ', 'makefile', 'make', 'json' },
--   callback = function()
--     vim.opt_local.expandtab = false
--     vim.opt_local.tabstop = 4
--     vim.opt_local.shiftwidth = 4
--     vim.opt_local.softtabstop = 4
--   end,
-- })

-- Languages that use 4 spaces
vim.api.nvim_create_autocmd('FileType', {
  group = indent_group,
  pattern = { 'python', 'java', 'php', 'rust', 'c', 'cpp', 'go', 'cs', 'makefile', 'make', 'json', 'html', 'templ' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Languages that use 2 spaces (default for most)
vim.api.nvim_create_autocmd('FileType', {
  group = indent_group,
  pattern = { 'lua', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'css', 'yaml', 'markdown', 'vue', 'svelte' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
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
