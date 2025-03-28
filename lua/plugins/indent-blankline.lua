local M = { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }
M.config = function()
    require("ibl").setup()
end
return M
