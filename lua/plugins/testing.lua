return {
  -- NeoTest for testing
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
    },
    keys = {
      { '<leader>tt', function() require('neotest').run.run() end, desc = 'Run nearest test' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, desc = 'Run all tests in file' },
      { '<leader>tl', function() require('neotest').run.run_last() end, desc = 'Run last test' },
      { '<leader>to', function() require('neotest').output.open { enter = true, auto_close = true } end, desc = 'Open test output' },
      { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle test summary' },
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
    end,
  },
}
