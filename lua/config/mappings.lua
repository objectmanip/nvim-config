vim.g.mapleader = " "
vim.g.localleader = " "
local map = vim.keymap.set
local map2 = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local remap_navigation = true -- remaps left, right, down, up to a, r, s, t respectively
local default_winsize_step = 20

--------------------------------------------------
-- Colemak
--------------------------------------------------
-- Control Backspace
map('n', 'gb', '<C-o>', { desc = 'Goto last positoin'})
map("i", "<C-h>", "<C-w>")
map("c", "<C-h>", "<C-w>")
map("n", '<A-q>', "<cmd>q<cr>")
map("n", "<leader>n", "<cmd>bnext<cr>", { desc = 'Move to next buffer' })
map("n", "n", "nzz", { noremap=true, silent=true})
map("n", "N", "Nzz", { noremap=true, silent=true})
-- move between windows
map("n", "<leader>ma", "<C-w>h", { desc = 'Move to Left Window'})
map("n", "<leader>mr", "<C-w>l", { desc = 'Move to Right Window'})
map("n", "<leader>mt", "<C-w>k", { desc = 'Move to Upper Window'})
map("n", "<leader>ms", "<C-w>j", { desc = 'Move to Lower Window'})
map("n", "<leader>lo", "<cmd>only<cr>", { desc = 'close all splits' })
map("n", "<leader>ca", "<cmd>qa!<cr>", { desc = 'close neovim'})
map("n", "<leader>sd", "<cmd>w<cr>", { desc = "save document" })
map("i", "<C-'>", "['\"]")
map("n", "gb", "<cmd>b#<cr>")
map("n", "G", "Gzz")
map("n", "<C-o>", "<C-o>zz")
map("n", "*", "*zz")
map("n", "<leader>rmf", function()
  local shada_dir = vim.fn.stdpath("data") .. "/shada"
  if vim.fn.isdirectory(shada_dir) == 1 then
    vim.fn.delete(shada_dir, "rf")
    print("Deleted shada folder: " .. shada_dir)
  else
    print("No shada folder found at: " .. shada_dir)
  end
end, { desc = "Delete shada folder" })

map("n", "<leader>tt", function()
  local bool_map = {
    ["true"] = "false",
    ["false"] = "true",
    ["yes"] = "no",
    ["no"] = "yes",
    ["on"] = "off",
    ["off"] = "on",
    ["all"] = "any",
    ["any"] = "all",
    ["is"] = "is not",
    ["not"] = "",
    [".old"] = "",
    ["enabled"] = "disabled",
    ["disabled"] = "enabled",
    ["enable"] = "disable",
    ["disable"] = "enable",
    [".lua"] = ".lua.old",
    [".lua.old"] = ".lua"
  }
  local word = vim.fn.expand("<cword>")
  local lower_word = word:lower()
  local replacement = bool_map[lower_word]
  if replacement then
    -- Preserve the original case if needed
    if word:sub(1,1):upper() == word:sub(1,1) then
      replacement = replacement:gsub("^%l", string.upper)
    end
    vim.cmd("normal! ciw" .. replacement)
  else
    local line = vim.api.nvim_get_current_line()
    local pattern = "([%w_]+)([,%);%]%}%>%s]*)$"
    local word, punctuation = line:match(pattern)

    if not word then return end

    local lower_word = word:lower()
    local replacement = bool_map[lower_word]
    if not replacement then return end

    -- Preserve case
    if word:sub(1,1):upper() == word:sub(1,1) then
      replacement = replacement:gsub("^%l", string.upper)
    end

    -- Replace the word at the end of the line
    local new_line = line:gsub(pattern, replacement .. punctuation)
    vim.api.nvim_set_current_line(new_line)
  end
end, { desc = "Toggle Values in Word or EOL)" })

function close_terminal_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
      local bufname = vim.api.nvim_buf_get_name(0)
      if buftype == 'terminal' then
        vim.api.nvim_buf_delete(buf, { force = true })
      elseif bufname:match("term://.*gitui.*toggleterm") then
        _gitui_ToggleTerm_Toggle()
      elseif bufname:match("term://.*nu.*toggleterm")
        or bufname:match("term://.*nu.*vtoggleterm::") then
        _nushell_ToggleTerm_Toggle()
      end
    end
  end
end
map("n", "<leader>tx", close_terminal_buffers, { desc = 'Close all terminal buffers'})

local function open_config_subpath(subpath)
    local os = vim.trim(vim.fn.system("uname -s"))
    local home = vim.fn.expand("~")
    local spath = ''

    if string.match(os, "Linux") then
        spath = home .. "/.config/nvim" .. subpath
    elseif string.match(os, "Darwin") then
        spath = home .. "/.config/nvim" .. subpath
    else
        spath = home .. "/AppData/Local/nvim" .. subpath
    end


    local stat = vim.loop.fs_stat(spath)

    if not stat then
      return
    end

    if stat.type == "file" then
      local success, _ = pcall(vim.cmd, "e " .. vim.fn.fnameescape(spath))
    else
      require("oil").open_float(vim.fn.fnameescape(spath))
    end
end
-- Define the keybind that opens the corresponding path based on OS
map("n", "<leader>ni", function() open_config_subpath('/init.lua') end, { desc="Open init.lua"})
map("n", "<leader>nm", function() open_config_subpath('/lua/config/mappings.lua') end, { desc="Open mappings.lua" })
map("n", "<leader>nl", function() open_config_subpath('/lua/core/lsp.lua') end, { desc="Open mappings.lua" })
map("n", "<leader>na", function() open_config_subpath('/lua/config/artwork.lua') end, { desc="Open artwork.lua" })
map("n", "<leader>np", function() open_config_subpath('/lua/plugins/') end, { desc="Open plugin_config.lua" })
map("n", "<leader>nt", function() open_config_subpath('/lua/config/theme.lua') end, { desc="Open theme.lua" })
map("n", "<leader>nw", function() open_config_subpath('/lua/config/workspaces.lua') end, { desc="Open workspaces.lua" })
map("n", "<leader>nb", function() open_config_subpath('/lua/plugins/blink.lua') end, { desc="Open workspaces.lua" })
-- move vertically in lines, even with linebreakblinks
map("n", "<up>", "gk")
map("n", "<down>", "gj")
map("v", "<up>", "gk")
map("v", "<down>", "gj")
map("n", "<leader>rr", "<cmd>redo<cr>", { desc = 'Redo' })
map("n", "<leader>uu", "<cmd>undo<cr>", { desc = 'Undo' })
-- move to beginning and end of line in any mode
map("i", "<C-a>", "<C-o><S-i>", { desc = 'Beginning of line' })
map("i", "<C-o>", "<C-o>$", { desc = 'End of line' })
-- navigation overrides

if remap_navigation then
  local navigation_keys = {
    ["n"] = {
      ["a"] = "h", -- left
      ["s"] = "gj", -- down
      ["t"] = "gk", -- up
      ["r"] = "l"  -- right
    },
    ["v"] = {
      ["a"] = "h", -- left
      ["s"] = "gj", -- down
      ["t"] = "gk", -- up
      ["r"] = "l"  -- right
    },
    ["x"] = {
      ["a"] = "h", -- left
      ["s"] = "j", -- down
      ["t"] = "k", -- up
      ["r"] = "l"  -- right
    },
    ["o"] = {
      ["a"] = "h", -- left
      ["s"] = "j", -- down
      -- ["t"] = "k", -- up
      ["r"] = "l"  -- right
    }
  }
  local nav_opts = { noremap = true, silent = true }
  -- Define a function to set key mappings
  local function set_navigation_mappings(mappings)
      for mode, map_table in pairs(mappings) do
          for lhs, rhs in pairs(map_table) do
            map(mode, lhs, rhs, nav_opts)
            map(mode, rhs, lhs, nav_opts)
          end
      end
  end

  -- Call the function with your mappings
  set_navigation_mappings(navigation_keys)
end
-- console workspace
--
map("n", "<C-i>", "a")
map("n", "<C-s>", "30<down>", { noremap = true, silent = true, desc = '30 Lines Down' })
map2("n", "<C-t>", "", { noremap = true })
map2("v", "<C-t>", "30<up>", { noremap = true, silent = true, desc = '30 Lines Up' })
-- Split window
map('n', '<leader>sv', ':vsplit<CR><C-w>l', { noremap = true, silent = true, desc = 'Create window right' })
map('n', '<leader>sh', ':split<CR><C-w>j', { noremap = true, silent = true, desc = 'Create window below' })
-- Resize window
map('n', '<leader>sr', function() vim.cmd("vertical resize +" ..default_winsize_step) end, { desc = 'Increase Window Width'})
map('n', '<leader>sa', function() vim.cmd("vertical resize -" ..default_winsize_step) end, { desc = 'Decrease Window Width'})
map('n', '<leader>st', function() vim.cmd("resize +" ..default_winsize_step) end, { desc = 'Increase Window Height'})
map('n', '<leader>ss', function() vim.cmd("resize -" ..default_winsize_step) end, { desc = 'Decrease Window Height'})
-- map('n', '<leader>fg', '<cmd>resize +500<CR>', { desc = 'Increase Window Height'})
map('n', '<leader>cw', '<C-w>c', { desc = 'Close active window'})
map('n', '<leader>co', '<C-w>o', { desc = 'Close other windows'})
map('n', '<leader>cu', '<C-w>u', { desc = 'Undo window closing'})
-- expand `cc` into CodeCompanion in the command line
map('n', '<C-c>', '"+y', { noremap = true, silent = true })
map('v', '<C-c>', '"+y', { noremap = true, silent = true })
-- Mark line (shift+home, shift+end functions)
map('n', '<S-Home>', 'v<Home>', { noremap = true, silent = true })
map('n', '<S-End>', 'v<End>', { noremap = true, silent = true })
map('i', '<S-Home>', '<Esc>v<Home>', { noremap = true, silent = true })
map('i', '<S-End>', '<Esc>v<End>', { noremap = true, silent = true })
-- map('n', '<leader>f', 'zfip', { desc = 'Folding Paragraph', noremap = true})
map("n", "<leader>qq", ":q!<cr>", { desc = 'Force Close Buffer' })
map("n", "<leader>wq", ":wq!<cr>", { desc = 'Force Close and Write Buffer'})
map("n", "<leader>h", "<cmd>noh<cr>", { desc = 'Hide search highlighting' })

usercmd("Time", function() print("Time is top right") end, {})
map("n", "<leader>tn", "<cmd>Time<cr>")

local function leave_only_current_buffer()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end
map("n", "<leader>bo", leave_only_current_buffer, { desc = "Close other buffers" })

local function close_pluginwindow()
  local bufname = vim.api.nvim_buf_get_name(0)
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype
  local vimmode = vim.api.nvim_get_mode().mode
  -- vim.notify(bufname .. ", " .. buftype .. ", " .. vimmode)
  if bufname:match("term://.*gitui.*toggleterm") then
    _gitui_ToggleTerm_Toggle()
  elseif bufname:match("term://.*nu.*toggleterm")
    or bufname:match("term://.*nu.*vtoggleterm::") then
    -- _nushell_ToggleTerm_Toggle()
    vim.cmd('q')
  elseif filetype:match('Avante') then
    vim.cmd('AvanteToggle')
  elseif buftype:match("nofile")
    or buftype:match("quickfix") then
    vim.cmd('q')
  elseif buftype:match("terminal") then
    if vimmode:match("nt") then
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-e>", true, false, true), 't', true)
    end
  end
end

map({'t', "n"}, "<esc>", close_pluginwindow)

map('n', "<leader>rh", function() vim.cmd("horizontal resize " .. vim.fn.input("New Height:")) end, { desc = 'Resize vertical'})
map('n', "<leader>rv", function() vim.cmd("vertical resize " .. vim.fn.input("New Width:")) end, { desc = 'Resize horizontal'})
function insertFullPath()
  local filepath = vim.fn.expand('%')
  vim.fn.setreg('+', filepath) -- write to clippoard
end

map('n', "<leader>yp", insertFullPath, { noremap = true, silent = true })
