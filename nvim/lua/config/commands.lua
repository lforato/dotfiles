--------------------------------------------------------------------------------
--- Filetype detection + per-filetype settings
--------------------------------------------------------------------------------

vim.filetype.add({
	extension = {
		sql = "sql",
	},
	pattern = {
		[".*%.html"] = "html",
	},
})

-- Disable diagnostics in .env* files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = ".env*",
	callback = function(args)
		vim.diagnostic.enable(false, { bufnr = args.buf })
	end,
})

-- Floating diagnostic on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end,
})

-- HTML uses 2-space indent
vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})

-- Split fillchars (eob handled in options.lua)
vim.opt.fillchars:append({
	horiz = "─",
	vert = "│",
	horizdown = "┬",
	horizup = "┴",
	vertright = "├",
	vertleft = "┤",
	verthoriz = "┼",
})
