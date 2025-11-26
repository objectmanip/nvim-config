local blink = require("blink.cmp")

local function get_venv(root)
  for _, name in ipairs({ "venv", ".venv" }) do
    local path = root .. "/" .. name
    if vim.fn.isdirectory(path) == 1 then
      return name  -- basedpyright wants just the folder name
    end
  end
  return nil
end

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
      venv = "venv",
      pythonPath = "./venv/bin/python",
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
