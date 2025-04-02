return {
  "0xstepit/flow.nvim",
  lazy = false,
  priority = 1000,
  tag = "v2.0.1",
    opts = {
      theme = {
        style = "dark", --  "dark" | "light"
        contrast = "default", -- "default" | "high"
        transparent = false, -- true | false
      },
      colors = {
        mode = "default", -- "default" | "dark" | "light"
        fluo = "green", -- "pink" | "cyan" | "yellow" | "orange" | "green"
        custom = {
          saturation = "100", -- "" | string representing an integer between 0 and 100
          light = "80", -- "" | string representing an integer between 0 and 100
        },
      },
      ui = {
        borders = "inverse", -- "theme" | "inverse" | "fluo" | "none"
        aggressive_spell = true, -- true | false
      },
    },
    config = function(_, opts)
      require("flow").setup(opts)
      vim.cmd("colorscheme flow")
    end,
  }
