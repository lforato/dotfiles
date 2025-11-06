local keymap = function(mode, keymap, cmd, opts)
  opts = opts or { noremap = true, silent = true }
	vim.keymap.set(mode, keymap, cmd, opts)
end

return keymap
