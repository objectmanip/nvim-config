local blink = require("blink.cmp")
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
      '.luarc.json',
      '.luarc.jsonc',
      '.luacheckrc',
      '.stylua.toml',
      'stylua.toml',
      'selene.toml',
      'selene.yml',
      '.git',
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.completionProvider then
      client.server_capabilities.completionProvider.triggerCharacters = {}
    end
  end,
  settings = {
      Lua = {
          autocomplete=false,
          diagnostics = {
              -- disable = { "missing-fields" },
              globals = {
                  "vim",
                  "Snacks",
              },
          },
          hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Enable",
              semicolon = "Disable",
              arrayIndex = "Enable",
          },
          completion = {
            callSnippet = "Disable"
          }
      },
  },
  capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      blink.get_lsp_capabilities(),
      {
          fileOperations = {
              didRename = true,
              willRename = true,
          },
      }
  ),
}
