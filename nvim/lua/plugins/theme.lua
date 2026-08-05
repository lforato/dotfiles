return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		transparent_mode = true,
		italic = {
			strings = true,
			comments = true,
			operators = false,
			folds = true,
			emphasis = true,
		},
		bold = true,
	},
	config = function(_, opts)
		require("gruvbox").setup(opts)
		vim.o.background = "dark"
		vim.cmd.colorscheme("gruvbox")
	end,
}
