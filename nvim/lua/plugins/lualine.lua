return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local theme = require("plugins.theme")
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = theme.name,
				component_separators = { left = " ", right = "|" },
				ignore_focus = { "NvimTree" },
				always_divide_middle = true,
				globalstatus = true,
				always_visible = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "filetype" },
				lualine_z = { "location", "progress" },
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
