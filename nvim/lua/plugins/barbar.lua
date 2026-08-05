return {
	"romgrk/barbar.nvim",
	version = "^1.0.0",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	-- barbar ships a plugin/ file that sets itself up at startup; deferring it is
	-- the single biggest startup win available here.
	event = "VeryLazy",
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
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
	},
}
