require("lang.typescript.lsp")

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyLoad",
	callback = function(args)
		if args.data == "nvim-dap" then
			require("lang.typescript.dap")
		end
	end,
})
