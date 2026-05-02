local theme = require("plugins.theme").colors
local hl = vim.api.nvim_set_hl

--------------------------------------------------------------------------------
--- Blink
--------------------------------------------------------------------------------

-- The completion menu window
hl(0, "BlinkCmpMenu", { bg = theme.transparent })

-- The completion menu window border
hl(0, "BlinkCmpMenuBorder", { bg = theme.transparent })

hl(0, "BlinkCmpDoc", { bg = theme.transparent })
hl(0, "BlinkCmpSignatureHelp", { bg = theme.transparent })
hl(0, "BlinkCmpMenuBorder", { fg = theme.light, bg = theme.transparent })
hl(0, "BlinkCmpDocBorder", { fg = theme.light, bg = theme.transparent })
hl(0, "BlinkCmpSignatureHelpBorder", { fg = theme.light, bg = theme.transparent })
hl(0, "BlinkCmpMenuSelection", { bg = theme.success, fg = theme.success_fg, bold = true })
hl(0, "BlinkCmpMenuItem", { bg = theme.transparent, fg = theme.light })
hl(0, "BlinkCmpMenuItemKind", { bg = theme.transparent, fg = theme.success })
hl(0, "BlinkCmpMenuItemDetail", { bg = theme.transparent, fg = theme.fg_dark })

--------------------------------------------------------------------------------
--- BarBar
--------------------------------------------------------------------------------

-- Other
hl(0, "BufferOffset", { bg = theme.bg0 }) -- The background of the header for a sidebar_filetype
hl(0, "BufferTabpageFill", { bg = theme.bg0 }) -- The space between the open buffer list and the tabpage
hl(0, "BufferTabpages", { bg = theme.bg0 }) -- The color of the tabpages indicator.
hl(0, "BufferTabpagesSep", { bg = theme.bg0 }) -- The separator between the tabpages count.

-- Current buffer
hl(0, "BufferCurrent", { bg = theme.bg0, fg = theme.success, bold = true }) -- The buffer itself
hl(0, "BufferCurrentMod", { bg = theme.bg0, fg = theme.success, bold = true }) -- the buffer itself when it is modified
hl(0, "BufferCurrentIcon", { fg = theme.success, bg = theme.bg0, bold = true }) -- the filetype icon
hl(0, "BufferCurrentSignRight", { fg = theme.success, bg = theme.bg0 })
hl(0, "BufferCurrentSign", { fg = theme.success, bg = theme.bg0 })

-- Inactive buffers
hl(0, "BufferInactive", { bg = theme.bg0, fg = theme.bg3 }) -- The buffer itself
hl(0, "BufferInactiveMod", { bg = theme.bg0, fg = theme.bg3 }) -- When modified
hl(0, "BufferInactiveIcon", { bg = theme.bg0, fg = theme.bg3 }) -- Filetype icon
hl(0, "BufferInactiveIndex", { bg = theme.bg0, fg = theme.bg3 }) -- Buffer index
hl(0, "BufferInactiveTarget", { bg = theme.bg0, fg = theme.bg3 }) -- Letter in buffer-pick mode
hl(0, "BufferInactiveSign", { bg = theme.bg0 }) -- Separator/sign
hl(0, "BufferInactiveSignRight", { fg = theme.light, bg = theme.bg0 })
