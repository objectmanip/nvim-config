local M = {
    'nvim-telescope/telescope.nvim', --, tag = '0.1.6',
       dependencies = {
      'nvim-lua/plenary.nvim' ,
      {
        "albenisolmos/telescope-oil.nvim",
            config = function()
                require("telescope").load_extension("oil")
            end
          },
      "debugloop/telescope-undo.nvim",
      "tomasky/bookmarks.nvim",
      'jsongerber/telescope-ssh-config',
  },
  config = function()
    require("telescope").setup({
      -- the rest of your telescope config goes here
      extensions = {
        undo = {
        },
        ['ssh-config'] = {
          client = 'oil',
          ssh_config_path = '~/.ssh/config',
        }
      },
    })
    require("telescope").load_extension("undo")
    vim.keymap.set("n", "<leader>tu", "<cmd>Telescope undo<cr>")
    require("telescope").load_extension("ssh-config")
    vim.keymap.set("n", '<leader>tr', "<cmd>Telescope ssh-config<CR>", { desc = 'Open an ssh connexion'} )
  end,
}

local builtin = require('telescope.builtin')

local api = vim.api
local uv = vim.loop
local function get_input()
  if vim.fn.mode() == "v" or vim.fn.mode() == "V" then
    local start_pos = api.nvim_buf_get_mark(0, "<")
    local end_pos = api.nvim_buf_get_mark(0, ">")
    local lines = api.nvim_buf_get_lines(0, start_pos[1] - 1, end_pos[1], false)
    if #lines == 0 then return "" end
    lines[1] = string.sub(lines[1], start_pos[2] + 1)
    if #lines > 1 then
      lines[#lines] = string.sub(lines[#lines], 1, end_pos[2] + 1)
    end
    return table.concat(lines, "\n")
  else
    return "" --vim.fn.expand("<cword>")
  end
end
local function find_root()
  local path = vim.fn.expand('%:p:h')
  for _ = 1, 3 do
    if uv.fs_stat(path .. '/.git') then
      return path
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then break end
    path = parent
  end
  return vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':h')
end
-- SEARCH BUFFER
local function smart_current_buffer_search()
  require('telescope.builtin').current_buffer_fuzzy_find({
    default_text = input ~= "" and input or nil,
    prompt_title = "Buffer Search",
  })
end
-- SEARCH PROJECT
local function smart_project_grep_lsp(live_grep)
  local api = vim.api
  local fn = vim.fn
  local builtin = require("telescope.builtin")
  local function get_lsp_root()
    local bufnr = api.nvim_get_current_buf()
    local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
      local wf = client.config.workspace_folders
      if wf and #wf > 0 then
        local path = vim.uri_to_fname(wf[1].uri)
        if fn.isdirectory(path) == 1 then return path end
      end
      local root = client.config.root_dir
      if root and fn.isdirectory(root) == 1 then return root end
    end
    return find_root()
  end
  if live_grep then
    builtin.live_grep({
      default_text = get_input(),
      cwd = get_lsp_root(),
      prompt_title = "Live Grep (LSP root)",
      additional_args = function() return {"--pcre2"} end,
    })
  else
    builtin.grep_string({
      search = get_input(),
      cwd = get_lsp_root(),
      prompt_title = "Live Grep (LSP root)",
      additional_args = function() return {"--pcre2"} end,
    })
  end
end


vim.keymap.set({ "n", "v" }, "<leader>/", smart_current_buffer_search, { desc = "Telescope: smart file search with context" })
vim.keymap.set({ "n", "v" }, "<leader>gf", function()
  smart_project_grep_lsp(true)
end, { desc = "Telescope: grep word in project" })
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[/] Find Files'})
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently used files' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[/] Find existing buffers' })
vim.keymap.set('n', '<leader>rf', ":Telescope oldfiles<CR>", { desc = '[.] Show recent files'})
vim.keymap.set('n', 'ml', '<cmd>Telescope bookmarks list<cr>', { desc = '[m] Show Bookmarks'})
-- vim.keymap.set('n', '/', function()
--   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({}))
-- end, { desc = '[/] Fuzzily search in current buffer', noremap = true, silent = true })

require("telescope").setup({
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      width = function(_, max_columns, _)
        return math.min(max_columns, 150)
      end,
    },
  },
  extensions = {
    aerial = {
      -- How to format the symbols
      format_symbol = function(symbol_path, filetype)
        if filetype == "json" or filetype == "yaml" then
          return table.concat(symbol_path, ".")
        else
          return symbol_path[#symbol_path]
        end
      end,
      -- Available modes: symbols, lines, both
      show_columns = "both",
    },
  },
})
vim.keymap.set("n", "gd", function()
    if vim.bo.filetype == "markdown" then
        vim.cmd('ObsidianFollowLink')
    else
        -- Check if an LSP client is attached to the current buffer
        local clients = vim.lsp.get_active_clients({ bufnr = 0 }) -- 0 means current buffer
        if not vim.tbl_isempty(clients) then
            -- At least one LSP client is active, try definition
            vim.lsp.buf.definition({
                on_list = function(options)
                    if options.items and not vim.tbl_isempty(options.items) then
                        require('telescope.builtin').lsp_definitions()
                    else
                        -- Fallback if LSP definition returns no results
                        -- require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })
                      require('telescope.builtin').current_buffer_fuzzy_find({ default_text = vim.fn.expand("<cword>") })
                    end
                end,
                -- You can also specify an on_finish callback to handle cases where no results are found at all
                -- even without an empty list being returned by on_list
                on_finish = function(success)
                    if not success then
                        -- This might indicate an error or simply no definition found by the LSP
                        require('telescope.builtin').current_buffer_fuzzy_find({ default_text = vim.fn.expand("<cword>") })
                        -- require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") })
                    end
                end
            })
        else
            -- No LSP client attached, directly fallback to grep_string
            vim.notify("No LSP server active for this buffer. Falling back to project search.", vim.log.levels.INFO)
            require('telescope.builtin').current_buffer_fuzzy_find({ default_text = vim.fn.expand("<cword>") })
        end
    end
end, { noremap = true, silent = true, desc = "LSP definition with fallback to grep" })-- vim.keymap.set("n", "gd", function()
--   if vim.bo.filetype == "markdown" then
--     vim.cmd('ObsidianFollowLink')
--   else
--     require('telescope.builtin').lsp_definitions()
--   end
-- end, { noremap = true, silent = true })
-- vim.keymap.set("n", "gd", function() require('telescope.builtin').lsp_definitions() end, { noremap = true, silent = true })
require('telescope').setup({
  defaults = {
    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
  },
  pickers = {
    find_files = {
      preview = {}
    }
  }
})

return M

