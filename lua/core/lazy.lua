-- install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
-- local preset = require("markview.presets");
--
-- require("markview").setup({
--     markdown = {
--         headings = preset.headings.glow,
--         horizontal_rules = preset.horizontal_rules.double,
--   },
-- })
