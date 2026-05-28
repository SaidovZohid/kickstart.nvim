return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('kanagawa').setup {
      colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
      overrides = function(colors)
        local theme = colors.theme

        return {
          ['@keyword.proto'] = { fg = theme.syn.keyword, italic = true },
          ['@keyword.import.proto'] = { fg = theme.syn.preproc },
          ['@keyword.function.proto'] = { fg = theme.syn.fun, bold = true },
          ['@keyword.return.proto'] = { fg = theme.syn.special3, italic = true },
          ['@type.proto'] = { fg = theme.syn.type },
          ['@property.proto'] = { fg = theme.syn.identifier },
          ['@variable.proto'] = { fg = theme.syn.identifier },
          ['@variable.member.proto'] = { fg = theme.syn.identifier },
        }
      end,
      theme = 'dragon',
      globalStatus = true,
      background = {
        dark = 'dragon',
        light = 'lotus',
      },
    }
    vim.cmd.colorscheme 'kanagawa-dragon'
  end,
}
