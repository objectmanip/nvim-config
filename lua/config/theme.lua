local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand
local theme_list = {
  'poimandres',
  'embark',
  'iceberg',
  'rose-pine',
  'flow',
  'lackluster-mint',
  'kanagawabones',
  'darkvoid',
  'eldritch',
  'moonfly'
}
local theme = theme_list[5]
vim.cmd("colorscheme " .. theme)
require('lualine').setup{
    options = {
      theme = theme,
    },
  }
local bluegreen = "#78ccc5"
local black = "#000000"
local white = "#ffffff"
local orange = "#ffaa00"
local red = "#c75c6a"
local darkblue = "#003366"
local paleyellow = '#3a3a3a'
local lavender = '#e6e6fa'
local purple = '#966fbc'
local slate = '#708090'
local slate_2 = '#4d5863'
local cyan = '#00ffff'
-- quicksettings
local cursoraxis = slate_2
local cursoraxis_insert = cursoraxis
local cursoraxis_visual = orange
local cursoraxis_delete = red
local cursoraxis_copy = cursoraxis
local colorcolumn_normal = red
local floatborder = white


local bg_transparency = 0.3
local default_cursorline = true
local default_cursorcolumn = true
local default_colorcolumn = "100"


vim.o.guifont = "Inconsolata:h12:#h-slight"
vim.opt.guicursor = {
  "n-v-c:block-Cursor",       -- Normal, Visual, Command modes: block cursor using Cursor hl
  "i-ci-ve:ver100-Cursor",    -- Insert and replace modes: vertical bar using Cursor hl
  "r-cr:hor20-Cursor",       -- Replace mode: horizontal bar using Cursor hl
  "o:hor50-Cursor",          -- Operator-pending mode
}
-- Define high-contrast cursor colors
vim.api.nvim_set_hl(0, 'Cursor', { fg = '#000000', bg = red })   -- Normal: bright green
vim.api.nvim_set_hl(0, 'iCursor', { fg = '#000000', bg = cyan })  -- Insert: bright cyan
vim.api.nvim_set_hl(0, 'rCursor', { fg = '#000000', bg = orange })  -- Replace: bright red
vim.api.nvim_set_hl(0, 'oCursor', { fg = '#000000', bg = '#ffff00' })

vim.o.linespace = 5
vim.api.nvim_set_hl(0, "LineNr", { fg = "#e3e3e3", bg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffaa00", bold = true })
vim.opt.cursorcolumn = default_cursorcolumn
vim.opt.cursorline = default_cursorline
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = cursoraxis })
vim.opt.colorcolumn = default_colorcolumn
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = colorcolumn_normal })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = floatborder, bg = "NONE" })
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("TerminalBorder", { clear = true }),
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = orange, bg = "NONE" })
    else
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = floatborder, bg = "NONE" })
    end
  end,
})
vim.api.nvim_set_hl(0, "MatchParen", { bold = true, fg = white, bg = purple })
vim.api.nvim_set_hl(0, "MatchWord", { underline = true, fg = word_fg })
