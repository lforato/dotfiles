return {
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
				-- Without this, tests and benches are never type-checked.
				allTargets = true,
			},
			procMacro = {
				enable = true,
			},
			inlayHints = {
				parameterHints = { enable = true },
				typeHints = { enable = true },
				chainingHints = { enable = true },
				closureReturnTypeHints = { enable = "with_block" },
			},
		},
	},
}
