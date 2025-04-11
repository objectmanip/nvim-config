# Keybinds
|mode|keybind|function|description|
|---|---|---|---|
|n|leader ap|cmd Alphacr |Open Dashboard|
|n|leader ?|builtin.oldfiles|[?] Find recently used files|
|n|leader fb|builtin.buffers|[/] Find existing buffers|
|n|leader sf|function(||
|n|leader rf|cmd CocRestartcr cr |Reload Coc|
|n|leader f|function()require'fzf-lua'.files({ cwd=vim.fn.expand('%:p:h') })end||
|n|leader oc|cmd Ollama Generate_Codecr |Ollama generate code|
|n|leader oe|cmd Ollama Explain_Codecr |Ollama explain code|
|v|leader oe|cmd Ollama Explain_Codecr |Ollama explain code|
|n|leader ac|cmd CodeCompanionChat Togglecr |CodeCompanionChat|
|n|leader /|cmd ToggleTerm dir=%:p:h name='Terminal' direction=floatcr |ToggleTerm|
|n|\\|cmd ToggleTerm dir=%:p:h name='Terminal' direction=floatcr |ToggleTerm|
|t|esc |close_toggleterm||
|n|-|cmd AerialToggle floatCR |AerialToggle|
|n|leader to|cmd Oil --floatCR |Oil Toggle|
|t|C-e |C-\\ C-n ||
|n|leader cc|cmd bdcr |Close Buffer|
|n|leader u|cmd Telescope undocr |Open Telescope UndoTree|
|n|leader cd|function() require("persistence").load() end|Load Last Session for Directory|
|n|leader ls|function() require("persistence").select() end|Load Session Menu|
|n|leader rs|function() require("persistence").load({ last = true }) end|Restore Last Session|
|n|leader qd|function() require("persistence").stop() end|Stop Persistence|
|n|leader gd|:CocCommand explorer.showDefinitionCR ||
|n|leader a|function() harpoon:list():add() end|Add to Harpoon|
|n|C-d |function() harpoon:list():remove(1) end||
|n|leader oh|function() harpoon.ui:toggle_quick_menu(harpoon:list()) end|Toggle Harpoon|
|n|C-1 |function() harpoon:list():select(1) end||
|n|C-2 |function() harpoon:list():select(2) end||
|n|C-3 |function() harpoon:list():select(3) end||
|n|C-4 |function() harpoon:list():select(4) end||
|n|C-S-P |function() harpoon:list():prev() end||
|n|C-S-N |function() harpoon:list():next() end||
|n|C-h |function() toggle_telescope(harpoon:list()||
|i|C-h |C-w ||
|c|C-h |C-w ||
|n|A-q |cmd qcr ||
|n|leader n|cmd bnextcr |Move to next buffer|
|n|n|nzz||
|n|N|Nzz||
|n|leader ma|C-w h|Move to Left Window|
|n|leader mr|C-w l|Move to Right Window|
|n|leader mt|C-w k|Move to Upper Window|
|n|leader ms|C-w j|Move to Lower Window|
|n|leader lo|cmd onlycr |close all splits|
|n|leader ca|cmd qa!cr |close neovim|
|n|leader tx|close_terminal_buffers|Close all terminal buffers|
|n|leader vi|function() open_config_subpath('/init.lua') end|Open init.lua|
|n|leader vm|function() open_config_subpath('/lua/config/mappings.lua') end|Open mappings.lua|
|n|leader vc|function() open_config_subpath('/lua/config/') end|Open nvim/lua/config|
|n|leader va|function() open_config_subpath('/lua/config/artwork.lua') end|Open artwork.lua|
|n|leader vp|function() open_config_subpath('/lua/config/plugin_config.lua') end|Open plugin_config.lua|
|n|leader vt|function() open_config_subpath('/lua/config/theme.lua') end|Open theme.lua|
|n|up |gk||
|n|down |gj||
|v|up |gk||
|v|down |gj||
|n|leader rr|cmd redocr |Redo|
|n|leader uu|cmd undocr |Undo|
|i|C-a |C-o S-i |Beginning of line|
|i|C-o |C-o $|End of line|
|n|C-i |a||
|n|C-s |30down |30 Lines Down|
|n|C-t |||
|v|C-t |30up |30 Lines Up|
|n|leader sv|:vsplitCR C-w l|Create window right|
|n|leader sh|:splitCR C-w j|Create window below|
|n|leader sr|cmd vertical resize +5CR |Increase Window Width|
|n|leader sa|cmd vertical resize -5CR |Decrease Window Width|
|n|leader st|cmd resize +5CR |Increase Window Height|
|n|leader gf|cmd resize +500CR |Increase Window Height|
|n|leader ss|cmd resize -5CR |Decrease Window Height|
|n|leader cw|C-w c|Close active window|
|n|leader co|C-w o|Close other windows|
|n|leader cu|C-w u|Undo window closing|
|n|C-c |+y||
|v|C-c |+y||
|n|S-Home |vHome ||
|n|S-End |vEnd ||
|i|S-Home |Esc vHome ||
|i|S-End |Esc vEnd ||
|n|leader qq|:q!cr |Force Close Buffer|
|n|leader wq|:wq!cr |Force Close and Write Buffer|
|n|leader h|cmd nohcr |Hide search highlighting|
|n|leader w|open_workspace||
