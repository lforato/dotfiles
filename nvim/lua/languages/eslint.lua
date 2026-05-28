vim.lsp.config("eslint", {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = {
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.ts",
		"package.json",
	},
	settings = {
		workingDirectory = { mode = "auto" },
	},
})

vim.lsp.enable("eslint")

local js_filetypes = {
	javascript = true,
	javascriptreact = true,
	["javascript.jsx"] = true,
	typescript = true,
	typescriptreact = true,
	["typescript.tsx"] = true,
}

vim.api.nvim_create_user_command("EslintEnable", function()
	vim.lsp.enable("eslint")
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) and js_filetypes[vim.bo[bufnr].filetype] then
			vim.api.nvim_exec_autocmds("FileType", { buffer = bufnr, modeline = false })
		end
	end
	vim.notify("ESLint enabled", vim.log.levels.INFO)
end, { desc = "Enable ESLint LSP" })

vim.api.nvim_create_user_command("EslintDisable", function()
	vim.lsp.enable("eslint", false)
	for _, client in ipairs(vim.lsp.get_clients({ name = "eslint" })) do
		client:stop(true)
	end
	vim.notify("ESLint disabled", vim.log.levels.INFO)
end, { desc = "Disable ESLint LSP" })

vim.api.nvim_create_user_command("EslintToggle", function()
	if #vim.lsp.get_clients({ name = "eslint" }) > 0 then
		vim.cmd("EslintDisable")
	else
		vim.cmd("EslintEnable")
	end
end, { desc = "Toggle ESLint LSP" })
