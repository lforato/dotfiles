return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
		{ "<leader>fg", function() require("telescope.builtin").git_files() end, desc = "Find Git files" },
		{ "<leader>fw", function() require("telescope.builtin").live_grep() end, desc = "Find in files" },
		{ "<leader>fr", function() require("telescope.builtin").resume() end, desc = "Resume last search" },
		{ "<C-p>", "<cmd>Telescope projects<cr>", desc = "Projects" },
	},
	opts = {
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
	},
}
