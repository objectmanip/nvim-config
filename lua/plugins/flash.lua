return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = true,
        keys = {},
        label = { exclude = "arstidcflh" },
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "j", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "M", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- { "J", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" }
    -- { "<leader>fl", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
