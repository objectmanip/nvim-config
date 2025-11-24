local M = {
	"L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp"
}


-- M.config = function()
-- end

vim.keymap.set(
  {"i"},
  "<C-K>",
  function()
    local ls = require("luasnip")
    ls.expand()
  end,
  { silent = true })

return M
