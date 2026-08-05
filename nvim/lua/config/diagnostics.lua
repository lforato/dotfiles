vim.diagnostic.config({
	-- Recomputing on every keystroke is expensive in a large TS project, and the
	-- results are mid-edit noise anyway.
	update_in_insert = false,
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
