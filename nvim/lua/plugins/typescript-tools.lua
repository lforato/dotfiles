return {
	"pmizio/typescript-tools.nvim",
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	keys = {
		{ "<leader>oi", "<cmd>TSToolsOrganizeImports<cr>", desc = "TS: Organize imports" },
		{ "<leader>ru", "<cmd>TSToolsRemoveUnusedImports<cr>", desc = "TS: Remove unused imports" },
		{ "<leader>oa", "<cmd>TSToolsAddMissingImports<cr>", desc = "TS: Add missing imports" },
		{ "<leader>fa", "<cmd>TSToolsFixAll<cr>", desc = "TS: Fix all" },
		{ "<leader>rf", "<cmd>TSToolsRenameFile<cr>", desc = "TS: Rename file" },
		{ "<leader>fR", "<cmd>TSToolsFileReferences<cr>", desc = "TS: File references" },
	},
	opts = {
		settings = {
			tsserver_file_preferences = {
				importModuleSpecifierPreference = "non-relative",
				includeInlayParameterNameHints = "all",
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
				quotePreference = "auto",
			},
			tsserver_format_options = {},
			complete_function_calls = true,
			expose_as_code_action = "all",
			jsx_close_tag = { enable = false, filetypes = { "javascriptreact", "typescriptreact" } },
		},
	},
}
