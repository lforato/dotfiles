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

-- 2. Set up LSP keymaps and behaviors on attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		-- Disable semantic tokens if needed
		client.server_capabilities.semanticTokensProvider = nil

		-- Keymaps
		local opts = { buffer = bufnr, noremap = true, silent = true }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	end,
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set loclist" })

--------------------------------------------------------------------------------
--- Languages
--------------------------------------------------------------------------------

require("lang.lua")
require("lang.typescript")
require("lang.go")
require("lang.templ")
require("lang.cpp")
require("lang.rust")
require("lang.cmake")
