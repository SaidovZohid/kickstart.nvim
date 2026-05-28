return {
  -- Auto pairs
  {
    'nvim-mini/mini.pairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Toggle terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    cmd = { 'ToggleTerm', 'TermExec' },
    keys = {
      [[<C-\>]],
      { '<leader>Tf', '<cmd>1ToggleTerm direction=float<cr>', desc = 'Terminal: [F]loat' },
      { '<leader>Th', '<cmd>2ToggleTerm direction=horizontal size=15<cr>', desc = 'Terminal: [H]orizontal' },
      { '<leader>Tv', '<cmd>3ToggleTerm direction=vertical size=80<cr>', desc = 'Terminal: [V]ertical' },
    },
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<c-\>]],
        direction = 'float',
        float_opts = {
          border = 'curved',
        },
      }
    end,
  },

  -- Search and replace (grug-far)
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>sr',
        function()
          require('grug-far').open()
        end,
        desc = '[S]earch and [R]eplace (grug-far)',
      },
      {
        '<leader>sw',
        function()
          require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } }
        end,
        desc = '[S]earch [W]ord under cursor (grug-far)',
      },
    },
    opts = {},
  },
}
