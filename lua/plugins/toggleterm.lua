local M = {
  {'akinsho/toggleterm.nvim', version = "*",
    opts = {
      start_in_insert=true,
      persist_mode=true,
      auto_scroll=true,
      dir='cwd',
      float_opts={
        border='double',
        width = function(_term)
          local width = math.ceil(vim.o.columns / 1.5)
          _term.float_opts.col = vim.o.columns - width + 10
          return width
        end,
        height = function(_term)
          local height = math.ceil(vim.o.lines / 2)
          _term.float_opts.row = vim.o.lines - height + 10
          return height
        end,
        -- width=function()
        --     return math.floor(vim.o.columns* 2/3)
        --   end,
        -- height=function()
        --     return math.floor(vim.o.lines / 2)
        --   end,
      },
    }
  }
}

local map = vim.keymap.set
local Terminal = require('toggleterm.terminal').Terminal

local function path_exists(path)
  return vim.loop.fs_stat(path) ~= nil
end
-- Helper to find project root based on presence of .git or README.md
local function find_project_root()
  local cwd = vim.fn.getcwd()
  local path = vim.fn.fnamemodify(cwd, ":p")  -- normalize
  local prev = ""
  while path ~= "/" and path ~= prev do
    if path_exists(path .. "/.git") or path_exists(path .. "/README.md") then
      return path
    end
    prev = path
    path = vim.fn.fnamemodify(path, ":h")
  end
  return cwd
end-- nushell pinned terminal
local nushell_ToggleTerm = nil
function _nushell_ToggleTerm_Toggle()
  if nushell_ToggleTerm == nil then
    local root = find_project_root()
    local activate_path_linux = root .. "/venv/bin/activate.nu"
    -- local activate_path_windows = root .. "\\venv\\Scripts\\activate.nu"
    local shell_cmd
    if path_exists(activate_path_linux) then
      shell_cmd = string.format("nu -c 'source %s; nu'", vim.fn.fnameescape(activate_path_linux))
      -- vim.notify("Opened terminal with virtual environment active")
    -- elseif path_exists(activate_path_windows) then
    --   shell_cmd = string.format("nu -c 'source %s; nu'", vim.fn.fnameescape(activate_path_windows))
    else
      shell_cmd = "nu"
    end

    nushell_ToggleTerm = Terminal:new({
      cmd = shell_cmd, -- replace with your desired command
      dir = root,
      direction = "horizontal", -- or "horizontal", "vertical"
      hidden = true
    })
  end
  nushell_ToggleTerm:toggle()
end

-- gitui floating window
local gitui_ToggleTerm = Terminal:new({
  cmd = "gitui", -- replace with your desired command
  direction = "float", -- or "horizontal", "vertical"
  hidden = true,
  float_opts = {
  border = "single",       -- or "single" | "double" | "shadow" | "none"
  winblend = 0,           -- transparency
  width = function()
    return math.floor(vim.o.columns * 0.7)
  end,
  height = function()
    return math.floor(vim.o.lines * 0.6)
  end,
  row = function()
    return math.floor((vim.o.lines - (vim.o.lines * 0.6)) / 2)
  end,
  col = function()
    return math.floor((vim.o.columns - (vim.o.columns * 0.7)) / 2)
  end,
},
})

function _gitui_ToggleTerm_Toggle()
  gitui_ToggleTerm:toggle()
end


map("n", "<leader>gg", _gitui_ToggleTerm_Toggle, { desc = "ToggleTerm"}, { desc = 'Open '})
map("n", "\\", _nushell_ToggleTerm_Toggle, { desc = "ToggleTerm"}, { desc = 'Open '})

return M
