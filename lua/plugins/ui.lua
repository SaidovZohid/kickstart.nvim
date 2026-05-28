return {
  -- Alpha dashboard
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.header.val = {
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '                                                     ',
      }

      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('r', '  Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', '  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      dashboard.section.footer.val = "Don't Stop Until You are Proud..."

      alpha.setup(dashboard.opts)
    end,
  },

  -- Mini.nvim modules (individual repos)
  {
    'nvim-mini/mini.ai',
    event = 'VeryLazy',
    opts = { n_lines = 500 },
  },
  {
    'nvim-mini/mini.surround',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'nvim-mini/mini.statusline',
    event = 'VeryLazy',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- Which-key
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>T', group = '[T]erminal' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>x', group = 'Trouble Diagnostics' },
        { '<leader>xt', group = 'Todo (Telescope)' },
      },
    },
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers',
          numbers = 'ordinal',
          diagnostics = 'nvim_lsp',
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = true,
          separator_style = 'thick',
          custom_filter = function(buf_number)
            local ft = vim.bo[buf_number].filetype
            local skip = { ['grug-far'] = true, oil = true, dbee = true, qf = true }
            return not skip[ft]
          end,
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              highlight = 'Directory',
              text_align = 'center',
            },
          },
        },
      }
    end,
  },

  -- Indent scope highlight (current scope only)
  {
    'nvim-mini/mini.indentscope',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { link = 'Comment' })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'alpha', 'dashboard', 'Trouble', 'lazy', 'mason', 'oil', 'dbee', 'grug-far' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Todo comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      search = {
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--glob=!**/swagger/**',
          '--glob=!**/swagger-ui*',
        },
      },
    },
  },

  -- Trouble.nvim - Better diagnostics list
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>xl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
    opts = {},
  },
}
