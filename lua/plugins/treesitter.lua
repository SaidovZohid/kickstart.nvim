return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          enable = true,
          max_lines = 0,
          trim_scope = 'outer',
          mode = 'cursor',
          separator = nil,
          zindex = 20,
        },
      },
    },
    config = function()
      local function enable_highlighting(buf)
        local filetype = vim.bo[buf].filetype
        if filetype == '' then
          return
        end

        -- When syntax highlighting is active, proto's built-in groups add clearer
        -- fallback colors for preview-style buffers.
        if filetype == 'proto' then
          vim.bo[buf].syntax = 'proto'
        end

        pcall(vim.treesitter.start, buf, filetype)
      end

      require('nvim-treesitter').install {
        'bash',
        'c',
        'diff',
        'go',
        'gomod',
        'gosum',
        'gowork',
        'html',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'php',
        'proto',
        'query',
        'sql',
        'templ',
        'vim',
        'vimdoc',
      }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          enable_highlighting(args.buf)
        end,
      })

      enable_highlighting(vim.api.nvim_get_current_buf())
    end,
  },
}
