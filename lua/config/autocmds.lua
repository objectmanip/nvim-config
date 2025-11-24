local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

-- Don't auto comment new lines
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

local function update_winbar()
  if #vim.api.nvim_list_wins() > 1 then
    vim.o.winbar= "%=%m%#Title# %f %="
  else
    vim.o.winbar = ""
  end
end

-- autocmd({"BufWinEnter", "WinEnter", "WinClosed"}, {
--   callback = update_winbar,
-- })

autocmd("VimEnter", {
  callback = function()
    if vim.o.columns > 200 and #vim.api.nvim_list_wins() == 1 then
      vim.cmd("vsplit")
      vim.cmd("wincmd l")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.json",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[ %s/'/"/ge ]])
    vim.fn.winrestview(view)
  end,
})

vim.api.nvim_create_user_command(
  "LP",
  function()
    require("persistence").load()
  end,
  {}
)

vim.api.nvim_create_user_command(
  "WS",
  function()
    open_workspace()
  end,
  {}
)

vim.api.nvim_create_user_command(
  "MF",
  function()
    open_workspace(true)
  end,
  {}
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.colorcolumn = ""
  end,
})

vim.api.nvim_create_autocmd("textyankpost", {
	desc = "highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set({"i", "n"}, "<C-l>", function()
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line = vim.api.nvim_get_current_line()
      local new_col = col
      local toggled = false

      -- Toggle any '- [ ]' or '- [x]' in the line
      local toggled_line, toggle_count = line:gsub("%- %[ %]", "- [x]", 1)
      if toggle_count == 0 then
        toggled_line, toggle_count = line:gsub("%- %[x%]", "- [ ]", 1)
      end
      if toggle_count > 0 then
        line = toggled_line
        toggled = true
      end

      -- Replace first '- ' not already a checkbox
      if not toggled then
        local replaced
        line, replaced = line:gsub("%- (?!%[)", "- [ ] ", 1)  -- Lua pattern doesn’t support negative lookahead; fallback below
        if replaced == 0 then
          -- crude way: match "- " not followed by "[" (by checking after the match)
          local dash_pos = line:find("%- ")
          if dash_pos and line:sub(dash_pos + 2, dash_pos + 2) ~= "[" then
            line = line:sub(1, dash_pos - 1) .. "- [ ] " .. line:sub(dash_pos + 2)
            toggled = true
          end
        else
          toggled = true
        end
      end

      -- Insert if no toggling or dash replacement occurred
      if not toggled then
        line = line:sub(1, col) .. "- [ ]" .. line:sub(col + 1)
        new_col = col + 6
      end

      vim.api.nvim_set_current_line(line)
      vim.api.nvim_win_set_cursor(0, { row, new_col })
    end, { buffer = true, desc = "Smart checkbox toggle/insert" })
  end,
})

