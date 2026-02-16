# About
Custom neovim config using lazy.vim and coc.
# Customizations
Dashooard is customized in `lua/plugins/alpha.lua`.
# Requirements
ripgrep
fd
fzf
nushell
git
npm
make

---

# Installed plugins

|plugin|description|plugin|description|
|---|---|---|---|
|aerial|Function Navigation|alpha|Dashboard and Startup|
|autopairs|Automatic pair completion|avante|AI Code Assistant|
|blender|Fast and flexible modeling tool integration|blink|Customizable screen blinking effect|
|bookmarks|Persistent file markers|dressing|Easy Vim Customization|
|flash|Code completion tool|fzf|powerful fuzzy searching tool|
|harpoon|Bookmarking system manager|indent-blankline|Automatic line blanking|
|lualine|Beautiful Status Line|luasnip|Lua Snippet Manager|
|mason|Dependency package manager|multinput|Multi Key Input Handler|
|obsidian|Note taking integration|oil|Buffer Style File Navigation|
|persistence|Automatic File Saving|plenary|Lua based config manager|
|project-cli-commands|Command line interface|regexplainer|Interactive Regex Analyzer|
|telescope|Fuzzy file finder|toggleterm-manager|Automatic Terminal Manager|
|toggleterm|Dynamic Floating Windows|treesitter|Syntax Tree Parser|
|twilight|Dark Mode Editor Enhancements|ufo|Powerful file navigation|
|web-devicons|Integrates Font Icons|which-key|Fuzzy Keybinding Lookup|

# Installed themes

|theme|theme|
|---|---|
|darkvoid|embark|
|flow|iceberg|
|lackluster|poimandres|
|rose-pine|zenbones|
# Keybinds
## autocmds.lua

|mode|keybind|function|description|
|---|---|---|---|
|{"i|n"}|\<C-l\>||

## mappings.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|gb|\<C-o\>|Goto last positoin|
|i|\<C-h\>|\<C-w\>||
|c|\<C-h\>|\<C-w\>||
|n|\<A-q\>|\<cmd\> q \<cr\>||
|n|\<leader\> n|\<cmd\> bnext \<cr\>|Move to next buffer|
|n|n|nzz||
|n|N|Nzz||
|n|\<leader\> ma|\<C-w\> h|Move to Left Window|
|n|\<leader\> mr|\<C-w\> l|Move to Right Window|
|n|\<leader\> mt|\<C-w\> k|Move to Upper Window|
|n|\<leader\> ms|\<C-w\> j|Move to Lower Window|
|n|\<leader\> lo|\<cmd\> only \<cr\>|close all splits|
|n|\<leader\> ca|\<cmd\> qa! \<cr\>|close neovim|
|n|\<leader\> sd|\<cmd\> w \<cr\>|save document|
|i|\<C-'\>|['\"]||
|n|gb|\<cmd\> b# \<cr\>||
|n|G|Gzz||
|n|\<C-o\>|\<C-o\> zz||
|n|*|*zz||
|n|\<leader\> rmf|function(||
|n|\<leader\> tt|function(||
|n|true|false||
|n|false|true||
|n|yes|no||
|n|no|yes||
|n|on|off||
|n|off|on||
|n|all|any||
|n|any|all||
|n|is|is not||
|n|not|||
|n|.old|||
|n|enabled|disabled||
|n|disabled|enabled||
|n|enable|disable||
|n|disable|enable||
|n|.lua|.lua.old||
|n|.lua.old|.lua||
|n|\<leader\> tx|close_terminal_buffers|Close all terminal buffers|
|n|\<leader\> ni|function() open_config_subpath('/init.lua') end|Open init.lua|
|n|\<leader\> nm|function() open_config_subpath('/lua/config/mappings.lua') end|Open mappings.lua|
|n|\<leader\> nl|function() open_config_subpath('/lua/core/lsp.lua') end|Open mappings.lua|
|n|\<leader\> na|function() open_config_subpath('/lua/config/artwork.lua') end|Open artwork.lua|
|n|\<leader\> np|function() open_config_subpath('/lua/plugins/') end|Open plugin_config.lua|
|n|\<leader\> nt|function() open_config_subpath('/lua/config/theme.lua') end|Open theme.lua|
|n|\<leader\> nw|function() open_config_subpath('/lua/config/workspaces.lua') end|Open workspaces.lua|
|n|\<leader\> nb|function() open_config_subpath('/lua/plugins/blink.lua') end|Open workspaces.lua|
|n|\<up\>|gk||
|n|\<down\>|gj||
|v|\<up\>|gk||
|v|\<down\>|gj||
|n|\<leader\> rr|\<cmd\> redo \<cr\>|Redo|
|n|\<leader\> uu|\<cmd\> undo \<cr\>|Undo|
|i|\<C-a\>|\<C-o\> \<S-i\>|Beginning of line|
|i|\<C-o\>|\<C-o\> $|End of line|
|n|a|h||
|n|s|gj||
|n|t|gk||
|n|r|l||
|n|a|h||
|n|s|gj||
|n|t|gk||
|n|r|l||
|n|a|h||
|n|s|j||
|n|t|k||
|n|r|l||
|n|a|h||
|n|s|j||
|n|r|l||
|n|\<C-i\>|a||
|n|\<C-s\>|30 \<down\>|30 Lines Down|
|n|\<C-t\>|||
|v|\<C-t\>|30 \<up\>|30 Lines Up|
|n|\<leader\> sv|:vsplit \<CR\> \<C-w\> l|Create window right|
|n|\<leader\> sh|:split \<CR\> \<C-w\> j|Create window below|
|n|\<leader\> sr|function() vim.cmd("vertical resize +" ..default_winsize_step) end|Increase Window Width|
|n|\<leader\> sa|function() vim.cmd("vertical resize -" ..default_winsize_step) end|Decrease Window Width|
|n|\<leader\> st|function() vim.cmd("resize +" ..default_winsize_step) end|Increase Window Height|
|n|\<leader\> ss|function() vim.cmd("resize -" ..default_winsize_step) end|Decrease Window Height|
|n|\<leader\> cw|\<C-w\> c|Close active window|
|n|\<leader\> co|\<C-w\> o|Close other windows|
|n|\<leader\> cu|\<C-w\> u|Undo window closing|
|n|\<C-c\>|+y||
|v|\<C-c\>|+y||
|n|\<S-Home\>|v \<Home\>||
|n|\<S-End\>|v \<End\>||
|i|\<S-Home\>|\<Esc\> v \<Home\>||
|i|\<S-End\>|\<Esc\> v \<End\>||
|n|\<leader\> qq|:q! \<cr\>|Force Close Buffer|
|n|\<leader\> wq|:wq! \<cr\>|Force Close and Write Buffer|
|n|\<leader\> h|\<cmd\> noh \<cr\>|Hide search highlighting|
|n|\<leader\> tn|\<cmd\> Time \<cr\>||
|n|\<leader\> bo|leave_only_current_buffer|Close other buffers|
|{'t|n"}|\<esc\>||
|n|\<leader\> rh|function() vim.cmd("horizontal resize " .. vim.fn.input("New Height:")) end|Resize vertical|
|n|\<leader\> rv|function() vim.cmd("vertical resize " .. vim.fn.input("New Width:")) end|Resize horizontal|
|n|\<leader\> yp|insertFullPath||

## options.lua
## workspaces.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> ws|open_workspace|Open language workspace|
|n|\<leader\> mf|open_main|Open language workspace|
|n|\<leader\> wo|OpenWorkspaceFiles|Load workspace buffers|
|n|\<leader\> ws|SaveWorkspaceFiles|Save workspace buffers|

## lsp.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> tl|toggle_virtual_lines|Toggle virtual lines|

## aerial.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|-|\<cmd\> AerialToggle right \<CR\>|AerialToggle|

## alpha.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> ap|\<cmd\> Alpha \<cr\>|Open Dashboard|

## blink.lua
## bookmarks.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|@t|☑️||
|n|@w|⚠️||
|n|@f|⛏||
|n|@n|||
|n|mm|bm.bookmark_toggle||
|n|mi|bm.bookmark_ann||
|n|mc|bm.bookmark_clean||
|n|mn|bm.bookmark_next||
|n|mp|bm.bookmark_prev||
|n|mx|bm.bookmark_clear_all||

## fzf.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> tf|find_git_root_or_parent||

## harpoon.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> a|function() harpoon:list():add() end|Add to Harpoon|
|n|\<leader\> oh|function() harpoon.ui:toggle_quick_menu(harpoon:list()) end|Toggle Harpoon|
|n|\<C-n\>|function() harpoon:list():next() end|Harpoon: Next Item|
|n|\<C-p\>|function() harpoon:list():prev() end|Harpoon: Next Item|
|n|g1|function() harpoon:list():select(1) end|Harpoon List 1|
|n|g2|function() harpoon:list():select(2) end|Harpoon List 2|
|n|g3|function() harpoon:list():select(3) end|Harpoon List 3|
|n|g4|function() harpoon:list():select(4) end|Harpoon List 4|
|n|g5|function() harpoon:list():select(4) end|Harpoon List 5|
|n|g6|function() harpoon:list():select(4) end|Harpoon List 6|
|n|g7|function() harpoon:list():select(4) end|Harpoon List 7|
|n|g8|function() harpoon:list():select(4) end|Harpoon List 8|
|n|g9|function() harpoon:list():select(4) end|Harpoon List 9|
|n|pb|function() harpoon:list():prev() end||
|n|nb|function() harpoon:list():next() end||
|n|\<leader\> oH|function() toggle_telescope(harpoon:list()||

## luasnip.lua
## obsidian.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> ofl|\<cmd\> ObsidianFollowLink \<cr\>|Obsidian: Follow Link|

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
|n|\<esc\>|actions.close||
|n|\<leader\> to|\<cmd\> Oil --float --preview \<cr\>|Oil Toggle|
|t|\<C-e\>|\<C-\\\> \<C-n\>||
|n|\<leader\> cc|\<cmd\> bd \<cr\> \<cmd\> bnext \<cr\>|Close Buffer|
|n|\<leader\> u|\<cmd\> Telescope undo \<cr\>|Open Telescope UndoTree|
|n|\<leader\> os|function(||

## persistence.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> cd|function() require("persistence").load() end|Load Last Session for Directory|
|n|\<leader\> ls|function() require("persistence").select() end|Load Session Menu|
|n|\<leader\> rs|function() require("persistence").load({ last = true }) end|Restore Last Session|
|n|\<leader\> qd|function() require("persistence").stop() end|Stop Persistence|

## project-cli-commands.lua
## telescope.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> u|\<cmd\> Telescope undo \<cr\>||
|n|\<leader\> fc|\<cmd\> Telescope ssh-config \<CR\>|Open an ssh connexion|
|{ "n|v" }|\<leader\> /|Telescope: smart file search with context|
|{ "n|v" }|\<leader\> gf||
|n|\<leader\> f|builtin.find_files|[/] Find Files|
|n|\<leader\> ?|builtin.oldfiles|[?] Find recently used files|
|n|\<leader\> sb|builtin.buffers|[/] Find existing buffers|
|n|\<leader\> rf|:Telescope oldfiles \<CR\>|[.] Show recent files|
|n|ml|\<cmd\> Telescope bookmarks list \<cr\>|[m] Show Bookmarks|
|n|gd|function(||

## toggleterm.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> gg|_gitui_ToggleTerm_Toggle|ToggleTerm|
|n|\\|_nushell_ToggleTerm_Toggle|ToggleTerm|

## twilight.lua

|mode|keybind|function|description|
|---|---|---|---|
|n|\<leader\> th|\<cmd\> Twilight \<cr\>|toggle twilight|

