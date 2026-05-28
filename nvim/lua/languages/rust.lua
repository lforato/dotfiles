vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = true,
			},
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				buildScripts = { enable = true },
			},
			checkOnSave = true,
			check = {
				command = "clippy",
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

vim.lsp.enable("rust_analyzer")
