function open_workspace(main_only)
  local main_only = main_only or false
  local split_width = "60"
  local cwd = vim.fn.getcwd()
  local files = vim.fn.readdir(cwd)
  local file_exists = function(name)
    return vim.fn.filereadable(cwd .. "/" .. name) == 1
  end
  local function open_file(file, cmd)
    if file_exists(file) then
      vim.cmd(cmd .. " " .. vim.fn.fnameescape(file))
    end
  end
  local function open_term()
    vim.cmd("term nu")
  end
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
  close_terminal_buffers()
  if file_exists("main.py") or file_exists("requirements.txt") then
    open_file("main.py", "edit")
    local main_win = vim.api.nvim_get_current_win()
    if main_only == false then
      open_file("README.md", split_width .. " vsplit")
      open_file("requirements.txt", "split")
    end
    vim.api.nvim_set_current_win(main_win)
  elseif file_exists("Cargo.toml") then
    -- Rust workspace
    open_file("src/main.rs", "edit")
    local main_win = vim.api.nvim_get_current_win()
    if  main_only == false then
      open_file("README.md", split_width .. " vsplit")
      open_file("Cargo.toml", "split")
    end
    vim.api.nvim_set_current_win(main_win)
  else
    vim.notify("No known workspace configuration found for this directory.", vim.log.levels.WARN)
  end
end
local function open_main()
  open_workspace(true)
end

vim.keymap.set("n", "<leader>ws", open_workspace, { desc = "Open language workspace" })
vim.keymap.set("n", "<leader>mf", open_main, { desc = "Open language workspace" })

-- function open_workspace()
--   vim.cmd(" vsplit")
--   vim.cmd("wincmd l")
--   vim.cmd("wincmd h")
--   vim.cmd("split")
--   vim.cmd("edit ./README.md")
--   vim.cmd("wincmd j")
--   vim.cmd("term")
--   vim.cmd("wincmd l")
-- end
-- map("n", "<leader>w", open_workspace)

local function get_workspace_file_path()
  -- Adjust if you want a different repo root detection
  local cwd = vim.fn.getcwd()
  return cwd .. "/workspace.txt"
end

-- Function: Open all files listed in workspace.txt
function OpenWorkspaceFiles()
  local path = get_workspace_file_path()
  local file = io.open(path, "r")
  if not file then
    vim.notify("workspace.txt not found", vim.log.levels.ERROR)
    return
  end

  for line in file:lines() do
    local trimmed = vim.fn.fnamemodify(vim.fn.trim(line), ":p")
    if vim.fn.filereadable(trimmed) == 1 then
      vim.cmd("edit " .. vim.fn.fnameescape(trimmed))
    else
      vim.notify("File not found: " .. trimmed, vim.log.levels.WARN)
    end
  end
  file:close()
end

-- Function: Write all open buffers (with filenames) into workspace.txt
function SaveWorkspaceFiles()
  local path = get_workspace_file_path()
  local file = io.open(path, "w")
  if not file then
    vim.notify("Failed to open workspace.txt for writing", vim.log.levels.ERROR)
    return
  end

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.api.nvim_buf_get_option(bufnr, "buflisted") then
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name ~= "" then
        local rel = vim.fn.fnamemodify(name, ":.")
        file:write(rel .. "\n")
      end
    end
  end

  file:close()
  vim.notify("Saved buffer list to workspace.txt")
end

vim.keymap.set("n", "<leader>wo", OpenWorkspaceFiles, { desc = "Load workspace buffers" })
vim.keymap.set("n", "<leader>ws", SaveWorkspaceFiles, { desc = "Save workspace buffers" })
