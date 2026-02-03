vim.lsp.config("neocmake", {
	cmd = { "neocmakelsp", "stdio" },
	filetypes = { "cmake" },
	root_markers = { ".git", "build", "cmake" },
})
vim.lsp.enable("neocmake")
