vim.diagnostic.config({
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	virtual_text = {
		source = "if_many",
		prefix = "● ",
	},
	float = {
		source = "always",
		focusable = true,
		style = "minimal",
		border = "rounded",
		header = "",
		prefix = "",
	},
})
