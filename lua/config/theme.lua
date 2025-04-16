require("config.artwork")
local theme = 'poimandres'
-----------------------------------------------------------------------------
--- ALPHA DASHBOARD ---

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = brailleart[math.random(1, table.getn(brailleart))]
-- Static buttons
local static_buttons = {
  dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
  dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}
-- Add 5 most recent files below the static ones
local function recent_files(n)
  local oldfiles = vim.v.oldfiles
  local buttons = {}
  local count = 0
  for _, file in ipairs(oldfiles) do
    if vim.fn.filereadable(file) == 1 and not file:match("^term://") then
      count = count + 1
      local shortname = vim.fn.fnamemodify(file, ":~:.")
      table.insert(buttons, dashboard.button(" " .. tostring(count), shortname, ":e " .. vim.fn.fnameescape(file) .. " <CR>"))
      if count >= n then break end
    end
  end
  return buttons
end

-- Combine static buttons with recent files
dashboard.section.buttons.val = vim.list_extend(static_buttons, recent_files(10))

-- dashboard.section.footer.val = { "neovim loaded." }
dashboard.config.layout = {
  { type = "padding", val = 10},
  dashboard.section.header,
  { type = "padding", val = 2},
  dashboard.section.buttons,
  { type = "padding", val = 1},
  dashboard.section.footer
}
dashboard.config.opts.noautocmd = true

alpha.setup(dashboard.config)
-----------------------------------------------------------------------------

if string.find(theme, 'rose-pine') then
  require("rose-pine").setup({
      variant = "moon", -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
          terminal = true,
          legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
      },

      styles = {
          bold = true,
          italic = true,
          transparency = false,
      },

      groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
      },

      palette = {
          -- Override the builtin palette per variant
          -- moon = {
          --     base = '#18191a',
          --     overlay = '#363738',
          -- },
      },

      highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
      },

      before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          -- if highlight.undercurl then
          --     highlight.undercurl = false
          -- end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --     highlight.fg = palette.foam
          -- end
      end,
  })
  vim.cmd("colorscheme rose-pine")
  -- vim.cmd("colorscheme rose-pine-main")
  -- vim.cmd("colorscheme rose-pine-moon")
  -- vim.cmd("colorscheme rose-pine-dawn")
elseif string.find(theme, "kanagawa") then
  require('kanagawa-paper').setup({
    undercurl = true,
    transparent = false,
    gutter = false,
    dimInactive = true, -- disabled when transparent
    terminalColors = true,
    commentStyle = { italic = true },
    functionStyle = { italic = true },
    keywordStyle = { italic = false, bold = false },
    statementStyle = { italic = false, bold = false },
    typeStyle = { italic = false },
    colors = {
      theme = {
        ink = {},
        canvas = {},
      },
      palette = {
        sumiInk0 = "#000000",
        fujiWhite = "#FFFFFF",
      }
    }, -- override default palette and theme colors
    color_offset = {
      canvas = {brightness = 0, saturation = 0},
    },
    overrides = function(colors)  -- override highlight groups
      return {}
    end
  })
  --- KANAGAWA ---
  if theme == 'kamigawa' then
    -- Default options:
    require('kanagawa').setup({
        compile = true,             -- enable compiling the colorscheme
        undercurl = true,            -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,         -- do not set background color
        dimInactive = true,         -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
        colors = {                   -- add/modify theme and palette colors
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
            return {}
        end,
        theme = "lotus",              -- Load "wave" theme
        background = {               -- map the value of 'background' option to a theme
            dark = "wave",           -- try "dragon" !
            light = "lotus"
        },
      })
    --- setup must be called before loading
    vim.cmd("colorscheme kanagawa-wave")
    -- local kanagawa_paper = require("lualine.themes.kanagawa-wave")
    -- require("lualine").setup({
    --   options = {
    --     theme = kanagawa_paper,
    --   },
    -- })
  end

  if theme == 'kanagawa-paper' then
    vim.cmd("colorscheme kanagawa-paper-ink")
    local kanagawa_paper = require("lualine.themes.kanagawa-paper-ink")
    -- local kanagawa_paper = require("lualine.themes.kanagawa-paper-canvas")
    require("lualine").setup({
      options = {
        theme = kanagawa_paper,
      },
    })
  end
elseif theme == "poimandres" then
  vim.cmd("colorscheme poimandres")
  require('lualine').setup{
      options = {
        theme = 'poimandres',
      },
    }
else
  vim.cmd("colorscheme " .. theme)
end

