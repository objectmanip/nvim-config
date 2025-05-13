# About
Custom neovim config using lazy.vim and coc.
# Installed plugins

|plugin|description|plugin|description|
|---|---|---|---|
|aerial|Context-aware documentation assistant|alpha|Advanced Command Line Interface|
|autopairs|Automatic pair completion|barbar|Minimalistic code completion|
|cmp-ai|Code completion with AI assistance|coc|Language Server Integration|
|comment|Code Comment Helper Tool|edgy|Configurable mouse integration|
|fzf|Fuzzy File Search Tool|harpoon|Link Based Project Manager|
|indent-blankline|Automatic indentation lines|limelight|Code line highlighting tool|
|lualine|Customizable Statusline Manager|luasnip|Lua snippet completion tool|
|magma|Modern Vim Emulator|markview|Contextual Bookmark Manager|
|modes|Configurable Text Editor Modes|noice|Dynamic UI Notifications|
|nvim-cmp|Autocomplete Code Completion|nvim-ts-autotag|Automatic HTML Tag Completion|
|obsidian|Note taking integration|oil|Lisp like code editor|
|ollama|Intelligent Code Completion|persistence|Persistent Session Management|
|plenary|Configuration File Management|project-cli-commands|Command line interface integration|
|telescope-oil|Interactive fuzzy finder|telescope-undo|Undo with Preview|
|telescope|Fuzzy file searching tool|toggleterm-manager|Manage Multiple Terminals|
|toggleterm|Terminal Tab Toggle|treesitter|Syntax Tree Parser|
|trouble|Error Management Tool|ufo|Powerful code navigation|
|web-devicons|Icon Font Manager|which-key|Fuzzy key binding lookup|

# Keybinds
## mappings.lua

|mode|keybind|function|description|
|---|---|---|---|
|i| \<C-h\> | \<C-w\> ||
|c| \<C-h\> | \<C-w\> ||
|n| \<A-q\> | \<cmd\> q \<cr\> ||
|n| \<leader\> n| \<cmd\> bnext \<cr\> |Move to next buffer|
|n|n|nzz||
|n|N|Nzz||
|n| \<leader\> ma| \<C-w\> h|Move to Left Window|
|n| \<leader\> mr| \<C-w\> l|Move to Right Window|
|n| \<leader\> mt| \<C-w\> k|Move to Upper Window|
|n| \<leader\> ms| \<C-w\> j|Move to Lower Window|
|n| \<leader\> lo| \<cmd\> only \<cr\> |close all splits|
|n| \<leader\> ca| \<cmd\> qa! \<cr\> |close neovim|
|n| \<leader\> sd| \<cmd\> w \<cr\> |save document|
|n| \<leader\> tx|close_terminal_buffers|Close all terminal buffers|
|n| \<leader\> vi|function() open_config_subpath('/init.lua') end|Open init.lua|
|n| \<leader\> vm|function() open_config_subpath('/lua/config/mappings.lua') end|Open mappings.lua|
|n| \<leader\> vc|function() open_config_subpath('/lua/config/') end|Open nvim/lua/config|
|n| \<leader\> va|function() open_config_subpath('/lua/config/artwork.lua') end|Open artwork.lua|
|n| \<leader\> vp|function() open_config_subpath('/lua/config/plugin_config.lua') end|Open plugin_config.lua|
|n| \<leader\> vt|function() open_config_subpath('/lua/config/theme.lua') end|Open theme.lua|
|n| \<up\> |gk||
|n| \<down\> |gj||
|v| \<up\> |gk||
|v| \<down\> |gj||
|n| \<leader\> rr| \<cmd\> redo \<cr\> |Redo|
|n| \<leader\> uu| \<cmd\> undo \<cr\> |Undo|
|i| \<C-a\> | \<C-o\> \<S-i\> |Beginning of line|
|i| \<C-o\> | \<C-o\> $|End of line|
|n|a|h||
|n|s|gj||
|n|t|gk||
|n|r|l||
|n|a|h||
|n|s|gj||
|n|t|gk||
|n|r|l||
|n| \<C-i\> |a||
|n| \<C-s\> |30 \<down\> |30 Lines Down|
|n| \<C-t\> |||
|v| \<C-t\> |30 \<up\> |30 Lines Up|
|n| \<leader\> sv|:vsplit \<CR\> \<C-w\> l|Create window right|
|n| \<leader\> sh|:split \<CR\> \<C-w\> j|Create window below|
|n| \<leader\> sr|function() vim.cmd("vertical resize +" ..default_winsize_step) end|Increase Window Width|
|n| \<leader\> sa|function() vim.cmd("vertical resize -" ..default_winsize_step) end|Decrease Window Width|
|n| \<leader\> st|function() vim.cmd("resize +" ..default_winsize_step) end|Increase Window Height|
|n| \<leader\> ss|function() vim.cmd("resize -" ..default_winsize_step) end|Decrease Window Height|
|n| \<leader\> fg| \<cmd\> resize +500 \<CR\> |Increase Window Height|
|n| \<leader\> cw| \<C-w\> c|Close active window|
|n| \<leader\> co| \<C-w\> o|Close other windows|
|n| \<leader\> cu| \<C-w\> u|Undo window closing|
|n| \<C-c\> |+y||
|v| \<C-c\> |+y||
|n| \<S-Home\> |v \<Home\> ||
|n| \<S-End\> |v \<End\> ||
|i| \<S-Home\> | \<Esc\> v \<Home\> ||
|i| \<S-End\> | \<Esc\> v \<End\> ||
|n| \<leader\> im| \<C-End\> if __name__ == "__main__": \<CR\> ||
|n| \<leader\> qq|:q! \<cr\> |Force Close Buffer|
|n| \<leader\> wq|:wq! \<cr\> |Force Close and Write Buffer|
|n| \<leader\> h| \<cmd\> noh \<cr\> |Hide search highlighting|
|n| \<leader\> w|open_workspace||
|n| \<leader\> tn| \<cmd\> Time \<cr\> ||

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
|n| \<leader\> or| \<cmd\> Ollama Raw \<cr\> |Ollama Open Chat Window|
|n| \<leader\> oe| \<cmd\> Ollama Explain_Code \<cr\> |Ollama explain code|
|v| \<leader\> oe| \<cmd\> Ollama Explain_Code \<cr\> |Ollama explain code|
|n| \<leader\> /| \<cmd\> ToggleTerm dir=%:p:h direction=float \<cr\> |ToggleTerm|
|n|\\| \<cmd\> ToggleTerm dir=%:p:h direction=float \<cr\> |ToggleTerm|
|t| \<esc\> |close_toggleterm||
|n|-| \<cmd\> AerialToggle float \<CR\> |AerialToggle|
|n| \<leader\> to| \<cmd\> Oil --float \<CR\> |Oil Toggle|
|t| \<C-e\> | \<C-\\\> \<C-n\> ||
|n| \<leader\> cc| \<cmd\> bd \<cr\> \<cmd\> bnext \<cr\> |Close Buffer|
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
|n| \<C-S-N\> |function() harpoon:list():next() end||
|n| \<C-h\> |function() toggle_telescope(harpoon:list()||
|n|g?|actions.show_help||
|n|\<CR\>|actions.select||
|n|\<C-s\>|actions.select|Open the entry in a vertical split|
|n|\<C-h\>|actions.select|Open the entry in a horizontal split|
|n|\<C-t\>|actions.select|Open the entry in new tab|
|n|\<C-p\>|actions.preview||
|n|\<C-c\>|actions.close||
|n|\<C-l\>|actions.refresh||
|n|-|actions.parent||
|n|_|actions.open_cwd||
|n|`|actions.cd||
|n|~|actions.cd|:tcd to the current oil directory|
|n|gs|actions.change_sort||
|n|gx|actions.open_external||
|n|g.|actions.toggle_hidden||
|n|g\\|actions.toggle_trash||
|n|\<esc\>|actions.close||

## nvim-cmp.lua
## nvim-ts-autotag.lua
## oil.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|g?|actions.show_help||
|n|\<CR\>|actions.select||
|n|\<C-s\>|actions.select|Open the entry in a vertical split|
|n|\<C-h\>|actions.select|Open the entry in a horizontal split|
|n|\<C-t\>|actions.select|Open the entry in new tab|
|n|\<C-p\>|actions.preview||
|n|\<C-c\>|actions.close||
|n|\<C-l\>|actions.refresh||
|n|-|actions.parent||
|n|_|actions.open_cwd||
|n|`|actions.cd||
|n|~|actions.cd|:tcd to the current oil directory", mode = "n|
|n|gs|actions.change_sort||
|n|gx|actions.open_external||
|n|g.|actions.toggle_hidden||
|n|g\\|actions.toggle_trash||

## project-cli-commands.lua
