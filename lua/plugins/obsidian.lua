local M = {
  "obsidian-nvim/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/obsidian/objectvault/",
      },
    },
    note_id_func = function(title)
      if title ~= nil and title ~= "" then
        -- Sanitize the title to create a valid filename
        local sanitized_title = title:gsub("[^%w%-%.%_ ]", ""):gsub(" ", "-"):lower()
        return sanitized_title
      else
        -- Fallback to default behavior (timestamp-based ID with random suffix)
        local suffix = ""
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
        return tostring(os.time()) .. "-" .. suffix
      end
    end,
  },
}

vim.keymap.set('n', '<leader>ofl', '<cmd>ObsidianFollowLink<cr>', { desc = 'Obsidian: Follow Link'})

return M
