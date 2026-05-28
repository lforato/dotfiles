return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-lint",
			"rshkarin/mason-nvim-lint",
		},
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {
				-- LSP servers
				"lua-language-server",
				"gopls",
				"rust-analyzer",
				"clangd",
				"typescript-language-server",
				"eslint-lsp",
				"neocmakelsp",
				-- Formatters
				"stylua",
				"prettier",
				"prettierd",
				"clang-format",
				"cmakelang",
				"shfmt",
				"black",
				"isort",
				-- Debug adapter
				"codelldb",
			},
			run_on_start = true,
			auto_update = false,
		},
	},
}
