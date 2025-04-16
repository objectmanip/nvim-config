--- NEOVIM CONFIG INIT ---
require("config.options")
require("config.autocmds")
require("config.mappings")
require("config.lazy")
require("config.plugin_config")
require("config.theme")
require("config.design")

vim.api.nvim_create_user_command(
  "LP",
  function()
    require("persistence").load()
  end,
  {}
)

vim.api.nvim_create_user_command(
  "WS",
  function()
    open_workspace()
  end,
  {}
)

