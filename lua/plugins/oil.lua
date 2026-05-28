return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ['<Esc>'] = 'actions.parent',
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'Oil',
}
