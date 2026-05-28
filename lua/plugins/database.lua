return {
  {
    'kndndrj/nvim-dbee',
    dependencies = { 'MunifTanjim/nui.nvim' },
    build = function()
      require('dbee').install()
    end,
    cmd = 'Dbee',
    keys = {
      { '<leader>db', function() require('dbee').toggle() end, desc = '[D]ata[B]ase UI Toggle (Dbee)' },
      { '<leader>do', function() require('dbee').open() end, desc = '[D]B [O]pen (Dbee)' },
      { '<leader>dc', function() require('dbee').close() end, desc = '[D]B [C]lose (Dbee)' },
    },
    config = function()
      require('dbee').setup {
        sources = {
          require('dbee.sources').EnvSource:new 'DBEE_CONNECTIONS',
          require('dbee.sources').FileSource:new(vim.fn.stdpath 'cache' .. '/dbee/persistence.json'),
        },
      }
    end,
  },
}
