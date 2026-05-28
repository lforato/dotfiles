return {
	"p00f/clangd_extensions.nvim",
	ft = { "c", "cpp", "objc", "objcpp", "cuda" },
	lazy = true,
	opts = {
		inlay_hints = {
			-- We use built-in vim.lsp.inlay_hint; let the LSP drive it.
			inline = false,
		},
		ast = {
			role_icons = {
				type = "",
				declaration = "",
				expression = "",
				specifier = "",
				statement = "",
				["template argument"] = "",
			},
			kind_icons = {
				Compound = "",
				Recovery = "",
				TranslationUnit = "",
				PackExpansion = "",
				TemplateTypeParm = "",
				TemplateTemplateParm = "",
				TemplateParamObject = "",
			},
			highlights = { detail = "Comment" },
		},
		memory_usage = { border = "rounded" },
		symbol_info = { border = "rounded" },
	},
	keys = {
		{ "<leader>cA", "<cmd>ClangdAST<cr>", desc = "Clangd: Show AST" },
		{ "<leader>cS", "<cmd>ClangdSymbolInfo<cr>", desc = "Clangd: Symbol info" },
		{ "<leader>cT", "<cmd>ClangdTypeHierarchy<cr>", desc = "Clangd: Type hierarchy" },
		{ "<leader>cM", "<cmd>ClangdMemoryUsage<cr>", desc = "Clangd: Memory usage" },
	},
}
