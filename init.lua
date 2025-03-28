--- NEOVIM CONFIG INIT ---
require("config.options")
require("config.autocmds")
require("config.mappings")
require("config.lazy")
require("config.plugin_config")
require("config.theme")
require("config.design")
-- require("config.lsps")
-- Open NeoTree automatically on startup
-- vim.cmd([[
--   augroup neotree_autostart
--     autocmd!
--     autocmd VimEnter * Neotree
--   augroup END
-- ]])

vim.api.nvim_create_user_command(
  "LP",
  function()
    require("persistence").load()
  end,
  {}
)
