return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Neo-tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    opts = {},
  },

  -- Toggle terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<C-_>]],
        direction = 'float',
        float_opts = {
          border = 'curved',
        },
      }
    end,
  },

  -- Search and replace
  {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Spectre',
    keys = {
      {
        '<leader>sr',
        function()
          require('spectre').toggle()
        end,
        desc = '[S]pectre [P]anel (Search & Replace)',
      },
      {
        '<leader>sw',
        function()
          require('spectre').open_visual { select_word = true }
        end,
        desc = '[S]pectre [W]ord under cursor',
      },
    },
    config = function()
      require('spectre').setup {
        open_cmd = 'vnew',
        live_update = true,
      }
    end,
  },
}
