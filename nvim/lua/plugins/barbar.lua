return {
	"romgrk/barbar.nvim",
	version = "^1.0.0",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("barbar").setup({
			auto_hide = 1,
			clickable = false,
			icons = {
				filetype = {
					enabled = true,
					custom_colors = true,
				},
				current = {
					filetype = {
						enabled = true,
					},
				},
			},
			exclude_name = {},
		})
	end,
}
