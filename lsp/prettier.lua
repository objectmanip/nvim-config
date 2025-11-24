
local blink = require("blink.cmp")
return {
  cmd = {'prettier' },
  on_attach = function(client, bufnr)
    if client.server_capabilities.completionProvider then
      client.server_capabilities.completionProvider.triggerCharacters = {}
    end
  end,
}
