local M = {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
  }
}

local map = vim.keymap.set
map("n", "<leader>cd", function() require("persistence").load() end, { desc = 'Load Last Session for Directory' })
map("n", "<leader>ls", function() require("persistence").select() end, { desc = 'Load Session Menu'})
map("n", "<leader>rs", function() require("persistence").load({ last = true }) end, { desc = 'Restore Last Session'})
map("n", "<leader>qd", function() require("persistence").stop() end, { desc = 'Stop Persistence' })

return M
