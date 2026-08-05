--------------------------------------------------------------------------------
--- Auto Commands
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--- Per-filetype indentation
--------------------------------------------------------------------------------

-- Filetypes whose toolchain expects hard tabs: make needs them to function at
-- all, gofmt and the Godot style guide both mandate them. A project's
-- .editorconfig still overrides this, reapplied by the FilePost handler below.
local tab_indented = {
	make = { tabstop = 8, shiftwidth = 8 },
	go = { tabstop = 4, shiftwidth = 4 },
	gomod = { tabstop = 4, shiftwidth = 4 },
	gdscript = { tabstop = 4, shiftwidth = 4 },
}

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user_indent", { clear = true }),
	callback = function(args)
		local indent = tab_indented[args.match]
		if not indent then
			return
		end

		-- Nvim applies .editorconfig on BufRead, before FileType, so without this
		-- guard these defaults would silently overwrite whatever the project asked
		-- for. vim.b.editorconfig holds the properties that actually got applied.
		local editorconfig = vim.b[args.buf].editorconfig
		if editorconfig and (editorconfig.indent_style or editorconfig.indent_size or editorconfig.tab_width) then
			return
		end

		vim.bo[args.buf].expandtab = false
		vim.bo[args.buf].softtabstop = 0
		vim.bo[args.buf].tabstop = indent.tabstop
		vim.bo[args.buf].shiftwidth = indent.shiftwidth
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
