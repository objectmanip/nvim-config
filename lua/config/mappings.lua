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

local function close_terminal_buffers()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
      if buftype == 'terminal' then
        vim.api.nvim_buf_delete(buf, { force = true})
      end
    end
  end
end

map("n", "<leader>tx", close_terminal_buffers, { desc = 'Close all terminal buffers'})
-- Function to determine the OS and open the respictive path to nvim config
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
    local success, _ = pcall(vim.cmd, "e " .. vim.fn.fnameescape(spath))
    -- if not sucess then
    --   vim.notify("Failed to open: " .. spath, vim.log.levels.ERROR)
    -- end
end
-- Define the keybind that opens the corresponding path based on OS
map("n", "<leader>vi", function() open_config_subpath('/init.lua') end, { desc="Open init.lua"})
map("n", "<leader>vm", function() open_config_subpath('/lua/config/mappings.lua') end, { desc="Open mappings.lua" })
map("n", "<leader>vc", function() open_config_subpath('/lua/config/') end, { desc="Open nvim/lua/config" })
map("n", "<leader>va", function() open_config_subpath('/lua/config/artwork.lua') end, { desc="Open artwork.lua" })
map("n", "<leader>vp", function() open_config_subpath('/lua/config/plugin_config.lua') end, { desc="Open plugin_config.lua" })
map("n", "<leader>vt", function() open_config_subpath('/lua/config/theme.lua') end, { desc="Open theme.lua" })
-- move vertically in lines, even with linebreaks
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
    }
  }
  -- Define a function to set key mappings
  local function set_navigation_mappings(mappings)
      for mode, map_table in pairs(mappings) do
          for lhs, rhs in pairs(map_table) do
            map(mode, lhs, rhs, { noremap = true, silent = true })
            map(mode, rhs, lhs, { noremap = true, silent = true })
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
map('n', '<leader>fg', '<cmd>resize +500<CR>', { desc = 'Increase Window Height'})
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

-- Terminal keybinds:
-- Language Specific Automations
-- python
-- Create an autocmd for Python files
autocmd('FileType', {
    pattern = 'python',
    callback = function()
        -- Set the keymap only for Python files
        map('n', '<leader>im', '<C-End>if __name__ == "__main__":<CR>', { noremap = true, silent = true })
    end
})

-- move line
map("n", "<leader>qq", ":q!<cr>", { desc = 'Force Close Buffer' })
map("n", "<leader>wq", ":wq!<cr>", { desc = 'Force Close and Write Buffer'})
map("n", "<leader>h", "<cmd>noh<cr>", { desc = 'Hide search highlighting' })
-- workspace
function open_workspace()
  vim.cmd("vsplit")
  vim.cmd("wincmd l")
  vim.cmd("wincmd h")
  vim.cmd("split")
  vim.cmd("edit ./README.md")
  vim.cmd("wincmd j")
  vim.cmd("term")
  vim.cmd("wincmd l")
end
map("n", "<leader>w", open_workspace)

usercmd("Time", function() print("Time is top right") end, {})
map("n", "<leader>tn", "<cmd>Time<cr>")
