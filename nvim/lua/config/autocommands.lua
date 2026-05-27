--------------------------------------------------------------------------------
--- Auto Commands
--------------------------------------------------------------------------------

-- Tab settings for Makefiles (tabs required)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 8
		vim.opt_local.shiftwidth = 8
		vim.opt_local.softtabstop = 0
	end,
})

-- Restore previous session when opening any non-$HOME directory
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
	callback = function()
		if vim.fn.getcwd() ~= vim.env.HOME then
			require("persistence").load()
		end
	end,
	nested = true,
})

vim.api.nvim_create_autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

		if not vim.g.ui_entered and args.event == "UIEnter" then
			vim.g.ui_entered = true
		end

		if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
			vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
			vim.api.nvim_del_augroup_by_name("NvFilePost")

			vim.schedule(function()
				vim.api.nvim_exec_autocmds("FileType", {})

				if vim.g.editorconfig then
					require("editorconfig").config(args.buf)
				end
			end)
		end
	end,
})

-- Open binary files in macOS Preview, keep buffer open, close Preview when buffer closes
local function open_in_preview(args)
	local filepath = vim.api.nvim_buf_get_name(args.buf)
	local filename = vim.fn.shellescape(filepath)
	local basename = vim.fn.fnamemodify(filepath, ":t")

	vim.cmd("silent !open -g " .. filename)

	vim.api.nvim_create_autocmd("BufDelete", {
		buffer = args.buf,
		once = true,
		callback = function()
			vim.fn.system({
				"osascript",
				"-e",
				'tell application "Preview" to close (every window whose name contains "' .. basename .. '")',
			})
		end,
	})
end

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*.pdf", "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
	callback = open_in_preview,
})
