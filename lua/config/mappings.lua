vim.g.mapleader = " "
vim.g.localleader = " "
local map = vim.keymap.set
local map2 = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd
local map_arst = true -- remaps left, right, down, up to a, r, s, t respectively

--------------------------------------------------
-- Colemak
--------------------------------------------------
-- Control Backspace
map("i", "<C-h>", "<C-w>")
map("c", "<C-h>", "<C-w>")
map("n", '<A-q>', "<cmd>q<cr>")
map("n", "<leader>n", "<cmd>bnext<cr>", { desc = 'Move to next buffer' })
map("n", "<leader>dw", "bdw", { desc = 'Delete Word' })
-- move between windows
map("n", "<leader>ma", "<C-w>h", { desc = 'Move to Left Window'})
map("n", "<leader>mr", "<C-w>l", { desc = 'Move to Right Window'})
map("n", "<leader>mt", "<C-w>k", { desc = 'Move to Upper Window'})
map("n", "<leader>ms", "<C-w>j", { desc = 'Move to Lower Window'})
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
-- Quick Access to neovim configuration
map("n", "<leader>vi", function() open_config_subpath('/init.lua') end)
map("n", "<leader>vm", function() open_config_subpath('/lua/config/mappings.lua') end)
map("n", "<leader>vc", function() open_config_subpath('/lua/config/') end)
map("n", "<leader>va", function() open_config_subpath('/lua/config/artwork.lua') end)
map("n", "<leader>vp", function() open_config_subpath('/lua/plugins/') end)
map("n", "<leader>vt", function() open_config_subpath('/lua/config/theme.lua') end)
-- move vertically in lines, even with linebreaks
map("n", "<leader>rr", "<cmd>redo<cr>", { desc = 'Redo' })
map("n", "<leader>uu", "<cmd>undo<cr>", { desc = 'Undo' })
-- move to beginning and end of line in any mode
map("i", "<C-a>", "<C-o><S-i>", { desc = 'Beginning of line' })
map("i", "<C-o>", "<C-o>$", { desc = 'End of line' })
if map_arst then
  map("n", "t", "gk")
  map("n", "s", "gj")
  map("v", "t", "gk")
  map("v", "s", "gj")
  map("n", "a", "<left>")
  map("n", "r", "<right>")
  -- map("n", "<C-r>", "<C-right>")
  -- map("n", "<C-a>", "<C-left>")
  map("v", "a", "<left>")
  map("v", "r", "<right>")
  -- map("v", "<C-r>", "<C-right>")
  -- map("v", "<C-a>", "<C-left>")
end
map("n", "<C-i>", "a")
map("n", "<C-s>", "30<down>", { noremap = true, silent = true, desc = '30 Lines Down' })
map2("n", "<C-t>", "", { noremap = true })
map2("v", "<C-t>", "30<up>", { noremap = true, silent = true, desc = '30 Lines Up' })
-- Split window
map('n', '<leader>sv', ':vsplit<CR><C-w>l', { noremap = true, silent = true, desc = 'Create window right' })
map('n', '<leader>sh', ':split<CR><C-w>j', { noremap = true, silent = true, desc = 'Create window below' })
-- Resize window
map('n', '<leader>sr', '<cmd>vertical resize +5<CR>', { desc = 'Increase Window Width'})
map('n', '<leader>sa', '<cmd>vertical resize -5<CR>', { desc = 'Decrease Window Width'})
map('n', '<leader>st', '<cmd>resize +5<CR>', { desc = 'Increase Window Height'})
map('n', '<leader>ss', '<cmd>resize -5<CR>', { desc = 'Decrease Window Height'})
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
map('n', '<leader>f', 'zfip', { desc = 'Folding Paragraph', noremap = true})

-- Terminal keybinds:
-- Language Specific Automations
-- python
-- Create an autocmd for Python files
autocmd('FileType', {
    pattern = 'python',
    callback = function()
        -- Set the keymap only for Python files
        map('n', '<leader>im', '<C-End>Oif __name__ == "__main__":<CR>', { noremap = true, silent = true })
    end
})

-- move line
map("n", "<leader>qq", ":q!<cr>", { desc = 'Force Close Buffer' })
map("n", "<leader>wq", ":wq!<cr>", { desc = 'Force Close and Write Buffer'})
map("n", "<leader>h", "<cmd>noh<cr>", { desc = 'Hide search highlighting' })

