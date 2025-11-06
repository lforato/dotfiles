local M = {}

M.gruvbox = {
	"ellisonleao/gruvbox.nvim",
	name = "gruvbox_dark",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			transparent_mode = true,
		})
		vim.o.background = "dark"
		vim.cmd([[colorscheme gruvbox]])
	end,
	colors = {
		transparent = "NONE",
		bg0 = "#1D2021",
		bg1 = "#282828",
		bg3 = "#928374",
		primary = "#fe8019",
		secondary = "#b8bb26",

		bg5 = "#fbf1c7",
		light = "#ebdbb2",
		success = "#fe8019",
		success_fg = "#282828",
		error = "#fb4934",
		warning = "#fabd2f",
	},

	lsp_colors = {
		Error = "#fb4934",
		Warning = "#fabd2f",
		Information = "#83a598",
		Hint = "#8ec07c",
	},
}

return M.gruvbox
