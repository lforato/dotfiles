local opt = vim.opt
local g = vim.g
local o = vim.o

--------------------------------------------------------------------------------
-- Leader Key
--------------------------------------------------------------------------------
g.mapleader = " " -- Space is the leader key

--------------------------------------------------------------------------------
-- Clipboard
--------------------------------------------------------------------------------
opt.clipboard = "unnamed"     -- Use system clipboard for yank/paste (older register)
o.clipboard = "unnamedplus"   -- Use system clipboard (+ register) for yank/paste

--------------------------------------------------------------------------------
-- File Backup & Undo
--------------------------------------------------------------------------------
opt.backup = false            -- Disable backup file creation
opt.swapfile = false          -- Disable swap files
opt.writebackup = false       -- Don't keep backup before overwriting
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Persistent undo directory
o.undofile = true             -- Enable persistent undo

--------------------------------------------------------------------------------
-- Search
--------------------------------------------------------------------------------
opt.hlsearch = false          -- Don't highlight search results after searching
opt.incsearch = true          -- Show matches as you type
o.ignorecase = true           -- Case-insensitive search...
o.smartcase = true            -- ...unless the search contains uppercase

--------------------------------------------------------------------------------
-- UI Appearance
--------------------------------------------------------------------------------
o.termguicolors = true        -- Enable true color support
opt.colorcolumn = "80"        -- Show column guide at 80 characters
opt.wrap = false              -- Disable line wrapping
opt.scrolloff = 8             -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8         -- Keep 8 columns left/right of cursor
opt.fillchars = { eob = " " } -- Remove ~ from empty lines
o.signcolumn = "yes"          -- Always show the sign column
o.winborder = "rounded"       -- Rounded window borders (for floating windows)
o.cursorline = true           -- Highlight current line
o.cursorlineopt = "number"    -- Highlight current line number

--------------------------------------------------------------------------------
-- Status & Tabs
--------------------------------------------------------------------------------
o.laststatus = 3              -- Global statusline
opt.showtabline = 2           -- Always show tabline
opt.showmode = false          -- Hide "-- INSERT --" (statusline handles this)
o.showmode = false            -- (Duplicate for safety)
o.splitkeep = "screen"        -- Keep same view when splitting

--------------------------------------------------------------------------------
-- Numbers
--------------------------------------------------------------------------------
o.number = true               -- Show absolute line numbers
opt.relativenumber = true     -- Show relative line numbers
o.numberwidth = 3             -- Width of line number column
o.ruler = false               -- Hide default ruler

--------------------------------------------------------------------------------
-- Completion
--------------------------------------------------------------------------------
opt.completeopt = { "menuone", "noselect", "noinsert" } -- Completion menu settings
opt.pumheight = 10            -- Max items in completion menu
opt.shortmess = opt.shortmess + { c = true } -- Less verbose messages

--------------------------------------------------------------------------------
-- Command Line
--------------------------------------------------------------------------------
opt.cmdheight = 1             -- Command line height

--------------------------------------------------------------------------------
-- Indentation
--------------------------------------------------------------------------------
o.expandtab = true            -- Convert tabs to spaces
o.shiftwidth = 2              -- Number of spaces per indent
o.smartindent = true          -- Smart auto-indenting
o.tabstop = 2                 -- Spaces per tab
o.softtabstop = 2             -- Spaces for <Tab> in insert mode

--------------------------------------------------------------------------------
-- Splits
--------------------------------------------------------------------------------
o.splitbelow = true           -- New horizontal splits below
o.splitright = true           -- New vertical splits to the right

--------------------------------------------------------------------------------
-- Timing
--------------------------------------------------------------------------------
opt.updatetime = 30           -- (Initial) CursorHold/update time (ms)
o.updatetime = 250            -- Override: 250ms for plugins like gitsigns
o.timeoutlen = 400            -- Time to wait for mapped sequence (ms)

--------------------------------------------------------------------------------
-- Mouse
--------------------------------------------------------------------------------
o.mouse = "a"                 -- Enable mouse in all modes

--------------------------------------------------------------------------------
-- Navigation
--------------------------------------------------------------------------------
opt.whichwrap:append("<>[]hl") -- Allow cursor to wrap with arrow keys/h/l

--------------------------------------------------------------------------------
-- Disable unused language providers
--------------------------------------------------------------------------------
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
