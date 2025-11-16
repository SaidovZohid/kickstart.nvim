return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('kanagawa').setup {
      colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
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
