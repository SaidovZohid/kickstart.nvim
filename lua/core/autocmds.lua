-- Autocommands

-- Filetype detection
vim.filetype.add {
  extension = {
    templ = 'templ',
    gotmpl = 'gotmpl',
    gohtml = 'gotmpl',
    gotxt = 'gotmpl',
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

local indent_width_by_ft = {
  python = 4, java = 4, php = 4, rust = 4, c = 4, cpp = 4, go = 4, cs = 4,
  makefile = 4, make = 4, json = 4, html = 4, templ = 4, sql = 4,
  lua = 2, javascript = 2, typescript = 2, javascriptreact = 2, typescriptreact = 2,
  css = 2, yaml = 2, markdown = 2, vue = 2, svelte = 2,
}

vim.api.nvim_create_autocmd('FileType', {
  group = indent_group,
  callback = function(args)
    local width = indent_width_by_ft[args.match]
    if not width then return end
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = width
    vim.opt_local.shiftwidth = width
    vim.opt_local.softtabstop = width
  end,
})

-- Quickfix list keymap
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf' },
  callback = function()
    vim.keymap.set('n', 'q', ':q<CR>', { buffer = true, silent = true })
  end,
})

-- Grug-far panel: q to close window + delete buffer
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'grug-far',
  callback = function(args)
    vim.keymap.set('n', 'q', function()
      local buf = args.buf
      pcall(vim.api.nvim_win_close, 0, true)
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end, { buffer = args.buf, silent = true, desc = 'Close grug-far panel' })
  end,
})

-- Alpha dashboard - disable folding
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'alpha',
  callback = function()
    vim.opt_local.foldenable = false
  end,
})

-- Regenerate code and refresh gopls when source files change (sqlc, protobuf, etc.)
local function restart_gopls()
  for _, client in ipairs(vim.lsp.get_clients { name = 'gopls' }) do
    local buffers = vim.lsp.get_buffers_by_client_id(client.id)
    vim.lsp.stop_client(client.id, true)
    -- Small delay to ensure clean restart
    vim.defer_fn(function()
      for _, bufnr in ipairs(buffers) do
        if vim.api.nvim_buf_is_valid(bufnr) then
          vim.cmd.edit { bang = true }
        end
      end
    end, 100)
  end
end

local generators = {
  sql   = { cmd = 'make sqlc',  label = 'sqlc' },
  proto = { cmd = 'make proto', label = 'Protobuf' },
}

local patterns = {}
for ext in pairs(generators) do
  table.insert(patterns, '*.' .. ext)
end

vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('gopls-refresh', { clear = true }),
  pattern = patterns,
  desc = 'Generate code and refresh gopls on save',
  callback = function(args)
    local gen = generators[vim.fn.fnamemodify(args.file, ':e')]
    if not gen then return end

    vim.notify('Generating ' .. gen.label .. ' and refreshing gopls...', vim.log.levels.INFO)
    vim.fn.jobstart(gen.cmd, {
      cwd = vim.fn.getcwd(),
      on_exit = function(_, exit_code)
        vim.schedule(function()
          if exit_code == 0 then
            restart_gopls()
            vim.notify(gen.label .. ' generated & gopls refreshed!', vim.log.levels.INFO)
          else
            vim.notify(gen.cmd .. ' failed', vim.log.levels.ERROR)
          end
        end)
      end,
    })
  end,
})
