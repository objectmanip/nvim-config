local M = {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
}

M.config = function()
  local map = vim.keymap.set
  local harpoon = require("harpoon")
  -- REQUIRED
  harpoon:setup()
  -- REQUIRED

  map("n", "<leader>a", function() harpoon:list():add() end, { desc = 'Add to Harpoon' })
  map("n", "<leader>oh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Toggle Harpoon' })
  map("n", "<C-n>", function() harpoon:list():next() end, { desc = 'Harpoon: Next Item'})
  map("n", "<C-p>", function() harpoon:list():prev() end, { desc = 'Harpoon: Next Item'})

  map("n", "g1", function() harpoon:list():select(1) end, { desc = 'Harpoon List 1' })
  map("n", "g2", function() harpoon:list():select(2) end, { desc = 'Harpoon List 2' })
  map("n", "g3", function() harpoon:list():select(3) end, { desc = 'Harpoon List 3' })
  map("n", "g4", function() harpoon:list():select(4) end, { desc = 'Harpoon List 4' })
  map("n", "g5", function() harpoon:list():select(4) end, { desc = 'Harpoon List 5' })
  map("n", "g6", function() harpoon:list():select(4) end, { desc = 'Harpoon List 6' })
  map("n", "g7", function() harpoon:list():select(4) end, { desc = 'Harpoon List 7' })
  map("n", "g8", function() harpoon:list():select(4) end, { desc = 'Harpoon List 8' })
  map("n", "g9", function() harpoon:list():select(4) end, { desc = 'Harpoon List 9' })

  -- Toggle previous & next buffers stored within Harpoon list
  map("n", "pb", function() harpoon:list():prev() end)
  map("n", "nb", function() harpoon:list():next() end)
  -- basic telescope configuration
  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
              results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
      }):find()
  end

  map("n", "<leader>oH", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open harpoon window" })
end

return M
