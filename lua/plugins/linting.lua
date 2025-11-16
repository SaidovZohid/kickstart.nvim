return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile', 'InsertLeave' },
    config = function()
      require('lint').linters_by_ft = {
        go = { 'golangcilint' },
      }

      if vim.bo.filetype == 'go' then
        require('lint').try_lint 'golangcilint'
      end

      -- Lint on save
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          if vim.bo.filetype == 'go' then
            require('lint').try_lint 'golangcilint'
          end
        end,
      })
    end,
  },
}
