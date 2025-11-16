return {
  -- NeoTest dependencies
  { 'nvim-neotest/nvim-nio' },

  -- NeoTest for testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-go' {
            experimental = {
              test_table = true,
            },
            args = { '-v' },
          },
        },
      }

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map('n', '<leader>tt', function()
        require('neotest').run.run()
      end, vim.tbl_extend('force', opts, { desc = 'Run nearest test' }))

      map('n', '<leader>tf', function()
        require('neotest').run.run(vim.fn.expand '%')
      end, vim.tbl_extend('force', opts, { desc = 'Run all tests in file' }))

      map('n', '<leader>tl', function()
        require('neotest').run.run_last()
      end, vim.tbl_extend('force', opts, { desc = 'Run last test' }))

      map('n', '<leader>to', function()
        require('neotest').output.open { enter = true, auto_close = true }
      end, vim.tbl_extend('force', opts, { desc = 'Open test output' }))

      map('n', '<leader>ts', function()
        require('neotest').summary.toggle()
      end, vim.tbl_extend('force', opts, { desc = 'Toggle test summary' }))
    end,
  },
}
