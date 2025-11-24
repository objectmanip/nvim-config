vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undodir')
vim.opt.undofile = true
vim.opt.spelllang = 'en,de'
vim.opt.laststatus = 3
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.winbar = "%f"

local builtin = require("statuscol.builtin")
local cfg = {
  setopt = true,         -- Whether to set the 'statuscolumn' option, may be set to false for those who
                         -- want to use the click handlers in their own 'statuscolumn': _G.Sc[SFL]a().
                         -- Although I recommend just using the segments field below to build your
                         -- statuscolumn to benefit from the performance optimizations in this plugin.
  -- builtin.lnumfunc number string options
  thousands = false,     -- or line number thousands separator string ("." / ",")
  relculright = false,   -- whether to right-align the cursor line number with 'relativenumber' set
  -- Builtin 'statuscolumn' options
  ft_ignore = nil,       -- lua table with 'filetype' values for which 'statuscolumn' will be unset
  bt_ignore = nil,       -- lua table with 'buftype' values for which 'statuscolumn' will be unset
  -- Default segments (fold -> sign -> line number + separator), explained below
  segments = {
    { text = { "%C" }, click = "v:lua.ScFa" },
    { text = { "%s" }, click = "v:lua.ScSa" },
    {
      text = { builtin.lnumfunc, " " },
      condition = { true, builtin.not_empty },
      click = "v:lua.ScLa",
    }
  },
  clickmod = "c",         -- modifier used for certain actions in the builtin clickhandlers:
                          -- "a" for Alt, "c" for Ctrl and "m" for Meta.
  clickhandlers = {       -- builtin click handlers
    Lnum                    = builtin.lnum_click,
    FoldClose               = builtin.foldclose_click,
    FoldOpen                = builtin.foldopen_click,
    FoldOther               = builtin.foldother_click,
    DapBreakpointRejected   = builtin.toggle_breakpoint,
    DapBreakpoint           = builtin.toggle_breakpoint,
    DapBreakpointCondition  = builtin.toggle_breakpoint,
    ["diagnostic/signs"]    = builtin.diagnostic_click,
    gitsigns                = builtin.gitsigns_click,
  },
}

