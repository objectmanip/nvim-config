local theme_list = {
  'poimandres',
  'rose-pine',
  'kanagawa',
  'kanagawa-paper-ink',
  'flow',
  'lackluster',
  'oh-lucy-evening',
  'oh-lucy',
  'sonokai',
  'everforest'
}
local theme = theme_list[10]
vim.cmd("colorscheme " .. theme)
require('lualine').setup{
    options = {
      theme = theme,
    },
  }
