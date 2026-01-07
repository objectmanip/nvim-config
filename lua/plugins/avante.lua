-- Run :AvanteBuild after first install
local M = {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = function()
    -- conditionally use the correct build system for the current OS
    if vim.fn.has("win32") == 1 then
      return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    else
      return "make"
    end
  end,
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
  -- -- OLLAMA SETTINGS
  --   -- provider = "ollama",
  --   -- providers = {
  --   --   ollama = {
  --   --     endpoint = "http://ollama.remote",
  --   --     model = "deepseek-coder-v2",
  --       -- timeout = 30000, -- Timeout in milliseconds
  --       --   extra_request_body = {
  --       --     temperature = 0.75,
  --       --     max_tokens = 20480,
  --       --   },
  -- -- GEMINI SETTINGS
    provider = "gemini",
    providers = {
      gemini = {
        -- model = "gemini-2.5-pro",
        model = "gemini-2.5-flash",
      },
    },
  },
  -- CLAUDE SONNET SETTINGS
    -- provider = "claude",
    -- providers = {
    --   claude = {
    --     endpoint = "https://api.anthropic.com",
    --     model = "claude-sonnet-4-5-20250929", -- Latest Sonnet 4.5
    --     api_key_name = "AVANTE_ANTHROPIC_API_KEY",
    --     timeout = 30000,
    --     extra_request_body = {
    --       temperature = 0.75,
    --       max_tokens = 20480,
    --     },
    --   },
    -- },
    behaviour = {
      support_paste_from_clipboard = true,
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}

return M
