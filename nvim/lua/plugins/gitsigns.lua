local function on_attach(bufnr)
	local gs = require("gitsigns")

	local function map(mode, lhs, rhs, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	map({ "n", "v" }, "]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gs.nav_hunk("next")
		end)
		return "<Ignore>"
	end, { expr = true, desc = "Jump to next hunk" })

	map({ "n", "v" }, "[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gs.nav_hunk("prev")
		end)
		return "<Ignore>"
	end, { expr = true, desc = "Jump to previous hunk" })

	map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle git blame line" })
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select git hunk" })
end

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil,
		max_file_length = 40000,
		preview_config = {
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		on_attach = on_attach,
	},
}
