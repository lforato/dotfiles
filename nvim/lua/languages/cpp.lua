vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=LLVM",
		"--pch-storage=memory",
		"--enable-config",
		"--limit-references=0",
		"--limit-results=0",
	},
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"CMakeLists.txt",
		".git",
	},
	capabilities = {
		-- clangd defaults to utf-16; allow utf-8 to silence offset-encoding warnings.
		offsetEncoding = { "utf-8", "utf-16" },
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
})

vim.lsp.enable("clangd")
