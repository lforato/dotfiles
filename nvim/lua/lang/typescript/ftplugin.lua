local function organize_imports_sync(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })
	if #clients == 0 then
		return
	end
	local client = clients[1]
	local params = {
		textDocument = vim.lsp.util.make_text_document_params(bufnr),
		range = {
			start = { line = 0, character = 0 },
			["end"] = { line = 0, character = 0 },
		},
		context = { only = { "source.organizeImports" }, diagnostics = {} },
	}
	local res = client:request_sync("textDocument/codeAction", params, 3000, bufnr)
	if not (res and res.result) then
		return
	end
	for _, action in ipairs(res.result) do
		if action.edit then
			vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
		end
		if type(action.command) == "table" then
			client:exec_cmd(action.command)
		end
	end
end

return function()
	local bufnr = vim.api.nvim_get_current_buf()
	local opts = function(desc)
		return { buffer = bufnr, desc = desc, silent = true }
	end

	vim.keymap.set("n", "<leader>fm", function()
		organize_imports_sync(bufnr)
		require("conform").format({ async = false, bufnr = bufnr })
	end, opts("Organize imports + format"))

	vim.keymap.set("n", "<leader>lf", function()
		vim.lsp.buf.code_action({
			context = { only = { "source.fixAll.eslint" }, diagnostics = {} },
			apply = true,
		})
	end, opts("ESLint: Fix all"))

	vim.keymap.set("n", "<leader>ld", function()
		vim.lsp.buf.code_action({
			context = { only = { "quickfix" }, diagnostics = vim.diagnostic.get(bufnr) },
		})
	end, opts("ESLint: Disable rule / quickfix"))

	vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart eslint<cr>", opts("ESLint: Restart"))
end
