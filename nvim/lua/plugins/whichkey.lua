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
			{ "<leader>a", group = "AI / Claude" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>f", group = "File" },
			{ "<leader>g", group = "Go to" },
			{ "<leader>o", group = "Open / Organize" },
			{ "<leader>r", group = "Refactor" },
			{ "<leader>t", group = "Toggle" },
		},
	},
}
