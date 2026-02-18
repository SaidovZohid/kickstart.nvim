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
  pattern = { 'python', 'java', 'php', 'rust', 'c', 'cpp', 'go', 'cs', 'makefile', 'make', 'json', 'html', 'templ', 'sql' },
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

-- ============================================================================
-- LSP Workspace Refresh for Generated Code (sqlc, protobuf, etc.)
-- ============================================================================

-- Function to restart gopls clients
local function restart_gopls()
  local clients = vim.lsp.get_clients({ name = 'gopls' })
  for _, client in ipairs(clients) do
    -- Get all buffers attached to this client
    local buffers = vim.lsp.get_buffers_by_client_id(client.id)

    -- Stop the client
    vim.lsp.stop_client(client.id, true)

    -- Small delay to ensure clean restart
    vim.defer_fn(function()
      -- Restart LSP for all previously attached buffers
      for _, bufnr in ipairs(buffers) do
        if vim.api.nvim_buf_is_valid(bufnr) then
          vim.cmd.edit({ bang = true })
        end
      end
    end, 100)
  end
end

-- Auto-refresh gopls after saving .sql files (sqlc) or .proto files (protobuf)
local gopls_refresh_group = vim.api.nvim_create_augroup('gopls-refresh', { clear = true })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = gopls_refresh_group,
  pattern = { '*.sql', '*.proto' },
  callback = function()
    -- Show notification
    vim.notify('Generating code and refreshing gopls...', vim.log.levels.INFO)

    -- Run generation command based on file type
    local file = vim.fn.expand('%:p')
    local cwd = vim.fn.getcwd()

    if file:match('%.sql$') then
      -- For sqlc files - using project's make command
      vim.fn.jobstart('make sqlc', {
        cwd = cwd,
        on_exit = function(_, exit_code)
          if exit_code == 0 then
            vim.schedule(function()
              restart_gopls()
              vim.notify('sqlc generated & gopls refreshed!', vim.log.levels.INFO)
            end)
          else
            vim.schedule(function()
              vim.notify('make sqlc failed', vim.log.levels.ERROR)
            end)
          end
        end,
      })
    elseif file:match('%.proto$') then
      -- For proto files - using project's make command
      vim.fn.jobstart('make proto', {
        cwd = cwd,
        on_exit = function(_, exit_code)
          if exit_code == 0 then
            vim.schedule(function()
              restart_gopls()
              vim.notify('Protobuf generated & gopls refreshed!', vim.log.levels.INFO)
            end)
          else
            vim.schedule(function()
              vim.notify('make proto failed', vim.log.levels.ERROR)
            end)
          end
        end,
      })
    end
  end,
  desc = 'Auto-generate and refresh gopls when saving .sql or .proto files',
})
