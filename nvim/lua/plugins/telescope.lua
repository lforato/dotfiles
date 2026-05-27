return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules/",
					"vendor/",
					".git/",
					"dist/",
					"build/",
					"%.lock",
					"%.svg",
					"%.otf",
					"%.ttf",
					"%.woff",
					"%.woff2",
					"%.min.js",
					"%.min.css",
				},
				border = true,
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			},
		})
	end,
}
