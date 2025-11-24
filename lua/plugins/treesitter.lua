return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",

  dependencies = {
  {
    "OXY2DEV/markview.nvim",
      lazy = false,
      branch = "main",
      opts = {
        preview = {
          filetypes = { "markdown", "Avante" },
          ignore_buftypes = {},
        },
        max_length = 99999,
      },
    },
  },
  config = function ()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query", "elixir",
        "heex", "javascript", "html", "yaml", "json", "markdown",
        "markdown_inline", "python", "nu"
      },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      folds = {
        enable = false,
      },
      experimental = {
        check_rtp_message = false,
      },
      indent = { enable = true },
    })
  end
 }
