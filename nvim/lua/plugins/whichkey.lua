return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		win = {
			no_overlap = true,
			border = "single",
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
			zindex = 1000,
		},
		spec = {
			{ "<leader>c", group = "Code" },
			{ "<leader>f", group = "File" },
			{ "<leader>g", group = "Go to" },
			{ "<leader>t", group = "Toggle" },
		},
	},
}
