return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-lint",
			"rshkarin/mason-nvim-lint",
		},
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts_extend = { "ensure_installed" },
		opts = {
			ensure_installed = {},
			run_on_start = true,
			auto_update = false,
		},
	},
}
