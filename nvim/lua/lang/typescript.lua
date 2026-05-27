vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	init_options = {
		hostInfo = "neovim",
		preferences = {
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayVariableTypeHintsWhenTypeMatchesName = true,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
			importModuleSpecifierPreference = "non-relative",
			quotePreference = "auto",
		},
	},
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
			suggest = {
				completeFunctionCalls = true,
			},
			format = {
				enable = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
			suggest = {
				completeFunctionCalls = true,
			},
			format = {
				enable = true,
			},
		},
	},
	handlers = {
		["_typescript.rename"] = function(_, result, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			vim.lsp.util.show_document({
				uri = result.textDocument.uri,
				range = {
					start = result.position,
					["end"] = result.position,
				},
			}, client.offset_encoding)
			vim.lsp.buf.rename()
			return vim.NIL
		end,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("ts_ls_attach", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.name ~= "ts_ls" then
			return
		end

		local bufnr = args.buf

		vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
			local source_actions = vim.tbl_filter(function(action)
				return vim.startswith(action, "source.")
			end, client.server_capabilities.codeActionProvider.codeActionKinds or {})

			vim.lsp.buf.code_action({
				context = {
					only = source_actions,
				},
			})
		end, { desc = "TypeScript source actions (organize imports, etc.)" })

		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.organizeImports" },
				},
				apply = true,
			})
		end, { buffer = bufnr, desc = "Organize imports" })

		vim.keymap.set("n", "<leader>ru", function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.removeUnused" },
				},
				apply = true,
			})
		end, { buffer = bufnr, desc = "Remove unused imports" })
	end,
})

vim.lsp.enable("ts_ls")

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

vim.api.nvim_create_user_command("EslintEnable", function()
	vim.lsp.enable("eslint")
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			local ft = vim.bo[bufnr].filetype
			if
				ft == "javascript"
				or ft == "javascriptreact"
				or ft == "javascript.jsx"
				or ft == "typescript"
				or ft == "typescriptreact"
				or ft == "typescript.tsx"
			then
				vim.api.nvim_exec_autocmds("FileType", { buffer = bufnr, modeline = false })
			end
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
