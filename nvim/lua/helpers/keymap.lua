local defaults = { noremap = true, silent = true }

return function(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", defaults, opts or {}))
end
