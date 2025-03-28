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

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, 'Visual', { bg = '#ff8800', fg = '#ffffff' })
    end,
})

local function update_winbar()
  if #vim.api.nvim_list_wins() > 1 then
    vim.o.winbar= "%=%m%#Title# %f %="
  else
    vim.o.winbar = ""
  end
end

vim.api.nvim_create_autocmd({"BufWinEnter", "WinEnter", "WinClosed"}, {
  callback = update_winbar,
})
