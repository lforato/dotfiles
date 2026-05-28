local ok, blink = pcall(require, "blink.cmp")
local blink_caps = ok and blink.get_lsp_capabilities() or {}

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

local function on_ts_attach(client, bufnr)
	vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
		local source_actions = vim.tbl_filter(function(action)
			return vim.startswith(action, "source.")
		end, client.server_capabilities.codeActionProvider.codeActionKinds or {})

		vim.lsp.buf.code_action({
			context = { only = source_actions },
		})
	end, { desc = "TypeScript source actions (organize imports, etc.)" })

	vim.keymap.set("n", "<leader>oi", function()
		vim.lsp.buf.code_action({
			context = { only = { "source.organizeImports" } },
			apply = true,
		})
	end, { buffer = bufnr, desc = "Organize imports" })

	vim.keymap.set("n", "<leader>ru", function()
		vim.lsp.buf.code_action({
			context = { only = { "source.removeUnused" } },
			apply = true,
		})
	end, { buffer = bufnr, desc = "Remove unused imports" })
end

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

		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		if client and client.name == "ts_ls" then
			on_ts_attach(client, bufnr)
		end

		if client and client.name == "clangd" then
			on_clangd_attach(client, bufnr)
		end
	end,
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set loclist" })

--------------------------------------------------------------------------------
--- Languages
--------------------------------------------------------------------------------

require("languages.lua")
require("languages.typescript")
require("languages.eslint")
require("languages.go")
require("languages.cpp")
require("languages.rust")
require("languages.cmake")
