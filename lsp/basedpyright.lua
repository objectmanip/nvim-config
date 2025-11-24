local blink = require("blink.cmp")
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { "python" },
  root_markers = {
    "main.py",
    "requirements.txt",
    ".git",
    "setup.py",
    "Pipfile",
    "pyrightconfig.json",
    "pyproject.toml"
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.completionProvider then
      client.server_capabilities.completionProvider.triggerCharacters = {}
    end
  end,
  settings = {
    basedpyright = {
      venvPath = ".",
      venv = "env_nu",
      disableLanguageServices = false,
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        typeCheckingMode = 'recommended',
        inlayHints = {
          variableTypes=true,
          callArgumentNames=true,
          functionReturnTypes=true,
          genericTypes=true,
          useLibraryCodeForTypes = true,
        },
      },
      -- openFilesOnly=true,
    }
  }
}
