local M = {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

M.config = function()
  require("codecompanion").setup({
    strategies = {
      chat = {
        adapter = "ollama",
      },
      inline = {
        adapter = "ollama",
      },
    },
    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          env = {
            url = "http://ollama.remote",
          },
          schema = {
            model = {
              default = "deepseek-coder-v2",
            },
          },
        })
      end,
    },
  })
end

return M
