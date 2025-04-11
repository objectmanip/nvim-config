return {
  {'akinsho/toggleterm.nvim', version = "*",
    opts = {
      start_in_insert=true,
      persist_mode=true,
      auto_scroll=true,
      dir='cwd',
      float_opts={
        border='double',
        width = function(_term)
          local width = math.ceil(vim.o.columns / 1.5)
          _term.float_opts.col = vim.o.columns - width + 10
          return width
        end,
        height = function(_term)
          local height = math.ceil(vim.o.lines / 2)
          _term.float_opts.row = vim.o.lines - height + 10
          return height
        end,
        -- width=function()
        --     return math.floor(vim.o.columns* 2/3)
        --   end,
        -- height=function()
        --     return math.floor(vim.o.lines / 2)
        --   end,
      },
    }
  }
}
