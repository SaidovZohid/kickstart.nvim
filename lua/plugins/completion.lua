return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'lukas-reineke/cmp-under-comparator',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
        }, {
          { name = 'buffer', priority = 500 },
          { name = 'path', priority = 250 },
        }),
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          ---@diagnostic disable-next-line: unused-local
          format = function(entry, vim_item)
            vim_item.kind = ({
              Text = '',
              Method = '',
              Function = '',
              Constructor = '',
              Field = '',
              Variable = '',
              Class = 'ﴯ',
              Interface = '',
              Module = '',
              Property = 'ﰠ',
              Unit = '',
              Value = '',
              Enum = '',
              Keyword = '',
              Snippet = '',
              Color = '',
              File = '',
              Reference = '',
              Folder = '',
              EnumMember = '',
              Constant = '',
              Struct = '',
              Event = '',
              Operator = '',
              TypeParameter = '',
            })[vim_item.kind] or vim_item.kind

            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              luasnip = '[Snippet]',
              buffer = '[Buffer]',
              path = '[Path]',
            })[entry.source.name]

            return vim_item
          end,
        },
        preselect = cmp.PreselectMode.None,
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require('cmp-under-comparator').under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
          max_items = 10,
        },
        experimental = {
          ghost_text = false,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
  },

  -- Copilot
  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
}
