local M = { 'feline-nvim/feline.nvim', branch = '0.5-compat' }

M.config = function()
    vim.opt.termguicolors = true
    require('feline').setup()
end

return M
