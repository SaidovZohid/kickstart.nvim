return {
  -- Gitsigns
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 200,
          virt_text_pos = 'eol',
          virt_text = true,
        },
      }
    end,
  },

  -- Diffview
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File History' },
    },
    opts = {
      keymaps = {
        view = {
          { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
        },
        file_panel = {
          { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
        },
        file_history_panel = {
          { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' } },
        },
      },
    },
  },

  -- Git conflict
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = true,
  },

  -- LazyGit
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
