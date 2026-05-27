return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "Spectre" },
	keys = {
		{
			"<leader>tr",
			function()
				require("spectre").toggle()
			end,
			desc = "Toggle Spectre refactor",
		},
	},
	opts = {},
}
