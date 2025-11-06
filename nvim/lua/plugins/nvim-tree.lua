local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set("n", "i", api.node.show_info_popup, opts("Info"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
	vim.keymap.set("n", "e", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "y", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "a", api.fs.create, opts("Create"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "d", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
	vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	enabled = true,
	lazy = false,
	async = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			on_attach = on_attach,
			git = {
				enable = true,
			},
			view = {
				side = "left",
				width = {
					min = 40,
					max = 100,
				},
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			renderer = {
				highlight_git = true,
				icons = {
					show = {
						git = true,
					},
				},
				indent_width = 2,
				indent_markers = {
					enable = true,
					icons = {
						corner = "└ ",
						edge = "│ ",
						item = "│ ",
						none = "  ",
					},
				},
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			update_focused_file = {
				enable = true,
				update_root = false,
				ignore_list = {},
			},
		})
	end,
}
