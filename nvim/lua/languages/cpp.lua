vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
	capabilities = {
		-- clangd defaults to utf-16; allow utf-8 to silence offset-encoding warnings.
		offsetEncoding = { "utf-8", "utf-16" },
	},
})

vim.lsp.enable("clangd")
