-- Core Neovim options
---@diagnostic disable-next-line: undefined-field
local opt = vim.opt

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd Font
vim.g.have_nerd_font = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Mouse
opt.mouse = 'a'

-- Mode display
opt.showmode = false

-- Clipboard
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Indentation
opt.breakindent = true
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.softtabstop = 2 -- Number of spaces tabs count for in edit mode
opt.smartindent = true -- Insert indents automatically

-- Undo
opt.undofile = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Sign column
opt.signcolumn = 'yes'

-- Update time
opt.updatetime = 250

-- Timeout
opt.timeoutlen = 300

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Whitespace characters
opt.list = false

-- Live substitution preview
opt.inccommand = 'split'

-- Cursor line
opt.cursorline = true

-- Scroll offset
opt.scrolloff = 10

-- Confirm unsaved changes
opt.confirm = true

-- Diagnostic configuration
vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}
