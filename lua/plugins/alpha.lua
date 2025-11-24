local M = {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
      require("config.artwork")
      local alpha = require("alpha")
      local artwork = math.random(1, #brailleart)
      local dashboard = require("alpha.themes.dashboard")
      local dashboard_header = brailleart[artwork]
      -- table.insert(dashboard_header, "\nci\" to remove and insert in next \"")
      dashboard.section.header.val = dashboard_header
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New File", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      local recent_files = {}
      for i, path in ipairs(vim.v.oldfiles) do
        if #recent_files >= 7 then break end
        if vim.fn.filereadable(path) == 1 then
          table.insert(recent_files,
            dashboard.button(tostring(i + 3), "  " .. vim.fn.fnamemodify(path, ":~"),
              "<cmd>e " .. path .. "<CR>")
          )
        end
      end
      for _, btn in ipairs(recent_files) do
        table.insert(dashboard.section.buttons.val, btn)
      end
      dashboard.section.footer.val = "🧘 Happy Coding\n"
      dashboard.config.layout = {
        { type = "padding", val = 10},
        dashboard.section.header,
        { type = "padding", val = 2},
        dashboard.section.buttons,
        { type = "padding", val = 1},
        dashboard.section.footer
      }
      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)
      local map = vim.keymap.set
      map("n", "<leader>ap", "<cmd>Alpha<cr>", { desc = "Open Dashboard" })
    end,
}


return M
