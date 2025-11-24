return {
  'saghen/blink.nvim',
  build = 'cargo build --release', -- for delimiters
  dependencies = {
{
  "saghen/blink.cmp",
      dependencies = {
        "moyiz/blink-emoji.nvim",
      },
      version = '1.*',
      -- build = 'cargo build --release',
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        enabled = function() return true end,
        keymap = {
          preset = 'none',
          ['<Tab>'] = { 'select_next', 'fallback' },
          ['<Down>'] = { 'select_next', 'fallback' },
          ['<Up>'] = { 'select_prev', 'fallback' },
          ['<C-n>'] = { 'select_next', 'fallback' },
          ['<C-p>'] = { 'select_prev', 'fallback' },
          ['<enter>'] = { 'accept' , 'fallback' },
          ['<C-e>'] = { 'cancel', 'fallback' },
        },
        snippets = {
          expand = function(snippet) vim.snippet.expand(snippet) end,
          active = function(filter) return vim.snippet.active(filter) end,
          jump = function(direction) vim.snippet.jump(direction) end,
          -- default = "luasnip",
        },
        completion = {
          keyword = {
              range = 'prefix',
          },
          list = {
            -- preselect = false,
            -- auto_insert = true,
          },
          -- auto_brackets = {
          --   enabled = true,
          --   kind_resolution = {
          --     enabled = true,
          --   },
          --   semantic_token_resolution = {
          --     enabled = true,
          --   },
          -- },
          trigger = {
            prefetch_on_insert = true,
          --   -- show_in_snippet = true,
          --   -- show_on_backspace = true,
          --   -- show_on_backspace_in_keyword = true,
          --   show_on_keyword = true,
          --   show_on_insert = true,
          --   -- show_on_trigger_character = true,
          --   show_on_blocked_trigger_characters = {},
          },
          documentation = {
            auto_show = false,
            auto_show_delay_ms = 500,
            update_delay_ms = 50,
            -- tresitter_highlighting = true,
            window = {
              border = 'single',
            },
          },
          menu = {
            enabled = true,
            auto_show = true,
            border = 'single',
          },
          ghost_text = {
            enabled = true,
            show_with_selection = true,
            show_without_selection = true,
            show_with_menu = true,
            show_without_menu = true,
          },
          accept = {
            auto_brackets = { enabled = true } ,

          },
        },
        fuzzy = {
          implementation = 'prefer_rust', --_with_warning',
          use_proximity = true,
          -- use_frequency = true,
          -- download = true,
        },
        sources = {
          default = { 'lsp', 'buffer', 'snippets', 'path', 'emoji' },
          providers = {
            lsp = {
              fallbacks = {} ,
              override = {
                get_trigger_characters = function(self)
                  local trigger_characters = self:get_trigger_characters()
                  vim.list_extend(trigger_characters, { '\n', '\t', ' ' })
                  return trigger_characters
                end
              },
            },
            emoji = {
              module = "blink-emoji",
              name = 'Emoji',
              score_offset = 15,
              opts = { insert = true },
              should_show_items = function ()
                return vim.tbl_contains(
                  {"gitcommit", "markdown"},
                  vim.o.filetype
                )
              end,
            },
          },
          min_keyword_length = 0,
        },
        signature = { enabled = true },
      },
    },
  "rafamadriz/friendly-snippets"
  },
  keys = {
	-- chartoggle
	{
	  ';',
	  function()
	  	require('blink.chartoggle').toggle_char_eol(';')
	  end,
	  mode = { 'n', 'v' },
	  desc = 'Toggle ; at eol',
	},
	{
	  ',',
	  function()
	  	require('blink.chartoggle').toggle_char_eol(',')
	  end,
	  mode = { 'n', 'v' },
	  desc = 'Toggle , at eol',
	},
	-- tree
	{ '<C-e>', '<cmd>BlinkTree reveal<cr>', desc = 'Reveal current file in tree' },
	{ '<leader>E', '<cmd>BlinkTree toggle<cr>', desc = 'Reveal current file in tree' },
	{ '<leader>e', '<cmd>BlinkTree toggle-focus<cr>', desc = 'Toggle file tree focus' },
  },
  -- all modules handle lazy loading internally
  lazy = false,
  opts = {
    chartoggle = { enabled = true },
    tree = { enabled = true }
  }
}

