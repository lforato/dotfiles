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
