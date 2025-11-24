vim.lsp.enable({
  'lua_ls',
  'basedpyright',
  "rust-analyzer",
})
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
    vim.opt.completeopt = {"menu", "menuone", "noinsert"} --, "noselect"}
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
  end
})
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = {current_line = true},
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.INFO] = "󰋽 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
        [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

-- Toggle virtual lines for diagnostics (not virtual text)
local virtual_lines_enabled = true

function _G.toggle_virtual_lines()
  virtual_lines_enabled = not virtual_lines_enabled
  local virtual_lines_value
  if virtual_lines_enabled == true then
    virtual_lines_value = { current_line=true }
  else
    virtual_lines_value = false
  end
  vim.diagnostic.config({
    virtual_lines = virtual_lines_value,
    virtual_text = false,  -- ensure virtual_text stays off
    underline = false,
    update_in_insert = true,
    severity_sort = true,
      signs = {
      text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
      numhl = {
          [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          [vim.diagnostic.severity.WARN] = "WarningMsg",
      },
    },
  })
  print("Virtual lines " .. (virtual_lines_enabled and "enabled" or "disabled"))
end

-- Optional keybinding
vim.keymap.set("n", "<leader>tl", toggle_virtual_lines, { desc = "Toggle virtual lines" })
