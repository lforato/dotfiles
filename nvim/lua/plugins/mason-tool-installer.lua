return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim" },
	event = "VeryLazy",
	opts_extend = { "ensure_installed" },
	opts = {
		ensure_installed = {
			-- LSP servers
			"lua-language-server",
			"gopls",
			"rust-analyzer",
			"clangd",
			"vtsls",
			"eslint-lsp",
			"neocmakelsp",
			"bash-language-server",
			"json-lsp",
			"yaml-language-server",
			"tailwindcss-language-server",
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
}
