return {
  'neoclide/coc.nvim',
  branch = 'release',
  config = function()
    vim.g.coc_global_extensions = {
      'coc-pyright',
      'coc-rust-analyzer',
      'coc-sumneko-lua',
      'coc-html',
      'coc-yaml',
      'coc-json',
      'coc-xml',
      'coc-toml',
      'coc-zig'
    }
    local keyset = vim.keymap.set
    keyset("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { silent = true })
    keyset("i", "<C-space>", "coc#refresh()", { silent = true, expr = true })
  end
}
