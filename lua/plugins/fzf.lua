local M = {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {}
}

local fzf_lua = require("fzf-lua")
local function find_git_root_or_parent()
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

  -- fallback to one level up if no .git found
  local cwd = git_dir or vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':h')

  fzf_lua.files({ cwd = cwd })
end

vim.keymap.set("n", "<leader>tf", find_git_root_or_parent)

return M
