local M = {
  'stevearc/aerial.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
}

M.config = function()
  require("aerial").setup({
    close_automatic_events = {
      "unfocus",
      "switch_buffer",
      "unsupported"
    },
    nav = {
      preview = true,
    },
    autojump = true,
    close_on_select = true,
  })
end

return M
