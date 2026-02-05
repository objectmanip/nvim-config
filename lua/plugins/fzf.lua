local M = {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  keys = {
    {
      "<leader>tf",
      function()
        local fzf_lua = require("fzf-lua")
        local uv = vim.loop
        local path = vim.fn.expand('%:p:h')
        local levels_checked = 0
        local git_dir = nil

        while path and levels_checked < 3 do
          local git_path = path .. "/.git"
          if uv.fs_stat(git_path) then
            git_dir = path
            break
          end
          local parent = vim.fn.fnamemodify(path, ":h")
          if parent == path then break end
          path = parent
          levels_checked = levels_checked + 1
        end
        local cwd = git_dir or vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':h')
        fzf_lua.files({ cwd = cwd })
      end,
      desc = "Find files fom git root or parent"
    }
  }
}

return M
