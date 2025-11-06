-----------------------------------------------------------------------------
--- Auto Commands
--------------------------------------------------------------------------------

-- This autocommand is used by the LSP to set up mappings for some commands
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf, remap = false }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "Y", vim.diagnostic.open_float)
	end,
})

-- Update lsp diagnostics on paste
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	callback = function()
		vim.diagnostic.setloclist({ open = false })
		vim.diagnostic.enable()
		vim.diagnostic.show()
	end,
})

-- This changes the tab width if user is in a Makefile
vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 8
		vim.opt_local.shiftwidth = 8
		vim.opt_local.softtabstop = 0
	end,
})

-- This autocommand gets the previous session from persistent on opening directory
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
