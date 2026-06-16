return {
  {
    'tpope/vim-dadbod',
    lazy = true,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
      'kristijanhusak/vim-dadbod-completion',
    },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    keys = {
      { '<leader>db', '<cmd>DBUIToggle<CR>', desc = '[D]ata[B]ase UI Toggle' },
      { '<leader>dba', '<cmd>DBUIAddConnection<CR>', desc = '[D]B [A]dd Connection' },
      { '<leader>dbf', '<cmd>DBUIFindBuffer<CR>', desc = '[D]B [F]ind Buffer' },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_open_windows_as_floating = 1
      vim.g.db_ui_execute_query_confirm = 1
      vim.g.db_ui_save_location = vim.fn.stdpath 'data' .. '/dadbod_ui'
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    dependencies = { 'tpope/vim-dadbod' },
    ft = { 'sql', 'mysql', 'plsql' },
  },
}
