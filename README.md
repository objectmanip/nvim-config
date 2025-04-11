# Keybinds
## plugin_config.lua
|mode|keybind|function|description|
|---|---|---|---|
|n| \<leader\> ap| \<cmd\> Alpha \<cr\> |Open Dashboard|
|n| \<leader\> ?|builtin.oldfiles|[?] Find recently used files|
|n| \<leader\> fb|builtin.buffers|[/] Find existing buffers|
|n| \<leader\> sf|function(||
|n| \<leader\> rf| \<cmd\> CocRestart \<cr\> \<cr\> |Reload Coc|
|n| \<leader\> f|function()require'fzf-lua'.files({ cwd=vim.fn.expand('%:p:h') })end||
|n| \<leader\> oc| \<cmd\> Ollama Generate_Code \<cr\> |Ollama generate code|
|n| \<leader\> oe| \<cmd\> Ollama Explain_Code \<cr\> |Ollama explain code|
|v| \<leader\> oe| \<cmd\> Ollama Explain_Code \<cr\> |Ollama explain code|
|n| \<leader\> ac| \<cmd\> CodeCompanionChat Toggle \<cr\> |CodeCompanionChat|
|n| \<leader\> /| \<cmd\> ToggleTerm dir=%:p:h name='Terminal' direction=float \<cr\> |ToggleTerm|
|n|\\| \<cmd\> ToggleTerm dir=%:p:h name='Terminal' direction=float \<cr\> |ToggleTerm|
|t| \<esc\> |close_toggleterm||
|n|-| \<cmd\> AerialToggle float \<CR\> |AerialToggle|
|n| \<leader\> to| \<cmd\> Oil --float \<CR\> |Oil Toggle|
|t| \<C-e\> | \<C-\\\> \<C-n\> ||
|n| \<leader\> cc| \<cmd\> bd \<cr\> |Close Buffer|
|n| \<leader\> u| \<cmd\> Telescope undo \<cr\> |Open Telescope UndoTree|
|n| \<leader\> cd|function() require("persistence").load() end|Load Last Session for Directory|
|n| \<leader\> ls|function() require("persistence").select() end|Load Session Menu|
|n| \<leader\> rs|function() require("persistence").load({ last = true }) end|Restore Last Session|
|n| \<leader\> qd|function() require("persistence").stop() end|Stop Persistence|
|n| \<leader\> gd|:CocCommand explorer.showDefinition \<CR\> ||
|n| \<leader\> a|function() harpoon:list():add() end|Add to Harpoon|
|n| \<C-d\> |function() harpoon:list():remove(1) end||
|n| \<leader\> oh|function() harpoon.ui:toggle_quick_menu(harpoon:list()) end|Toggle Harpoon|
|n| \<C-1\> |function() harpoon:list():select(1) end||
|n| \<C-2\> |function() harpoon:list():select(2) end||
|n| \<C-3\> |function() harpoon:list():select(3) end||
|n| \<C-4\> |function() harpoon:list():select(4) end||
|n| \<C-S-P\> |function() harpoon:list():prev() end||
