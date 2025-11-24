
local blink = require("blink.cmp")
return {
  cmd = {'stylua' },
  filetypes = {'lua'},
  on_attach = function(client, bufnr)
    if client.server_capabilities.completionProvider then
      client.server_capabilities.completionProvider.triggerCharacters = {}
    end
  end,
}
