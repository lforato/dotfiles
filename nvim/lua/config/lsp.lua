local ok, blink = pcall(require, "blink.cmp")
local blink_caps = ok and blink.get_lsp_capabilities() or {}

-- Defaults applied to every LSP client via deep-merge with each lsp/<name>.lua spec.
vim.lsp.config("*", {
	capabilities = vim.tbl_deep_extend("force", {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
			selectionRange = {
				dynamicRegistration = false,
			},
			completion = {
				completionItem = {
					documentationFormat = { "markdown", "plaintext" },
					snippetSupport = true,
					preselectSupport = true,
					insertReplaceSupport = true,
					labelDetailsSupport = true,
					deprecatedSupport = true,
					commitCharactersSupport = true,
					tagSupport = { valueSet = { 1 } },
					resolveSupport = {
						properties = {
							"documentation",
							"detail",
							"additionalTextEdits",
						},
					},
				},
			},
		},
	}, blink_caps),
	root_markers = { ".git" },
})

--------------------------------------------------------------------------------
-- Per-server attach handlers
--------------------------------------------------------------------------------

local function on_clangd_attach(client, bufnr)
	vim.keymap.set("n", "<leader>oh", function()
		local params = vim.lsp.util.make_text_document_params(bufnr)
		client:request("textDocument/switchSourceHeader", params, function(err, result)
			if err then
				vim.notify(tostring(err), vim.log.levels.ERROR)
				return
			end
			if not result then
				vim.notify("No matching source/header file", vim.log.levels.WARN)
				return
			end
			vim.cmd.edit(vim.uri_to_fname(result))
		end, bufnr)
	end, { buffer = bufnr, desc = "Switch header/source" })
end

local eslint_commands_registered = false
local function on_eslint_attach()
	if eslint_commands_registered then
		return
	end
	eslint_commands_registered = true

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
end

local attach_handlers = {
	clangd = on_clangd_attach,
	eslint = on_eslint_attach,
}

--------------------------------------------------------------------------------
-- Unified LspAttach: generic keymaps + inlay hints + per-server dispatch
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc })
		end

		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		map("n", "gr", vim.lsp.buf.references, "References")
		map("n", "K", vim.lsp.buf.hover, "Hover docs")
		map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "Y", vim.diagnostic.open_float, "Show diagnostic float")
		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Previous diagnostic")
		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Next diagnostic")

		local handler = client and attach_handlers[client.name]
		if handler then
			handler(client, bufnr)
		end
	end,
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set loclist" })

vim.keymap.set("n", "<leader>th", function()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

vim.lsp.enable({
	"lua_ls",
	"clangd",
	"gopls",
	"rust_analyzer",
	"neocmake",
	"eslint",
	"gdscript",
	"ts_ls",
})
