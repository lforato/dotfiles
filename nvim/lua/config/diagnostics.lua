vim.diagnostic.config({
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
	virtual_text = {
		source = "if_many",
		prefix = "● ",
	},
	float = {
		source = true,
		focusable = true,
		style = "minimal",
		border = "rounded",
		header = "",
		prefix = "",
	},
})
