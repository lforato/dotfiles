local ok, blink = pcall(require, "blink.cmp")
local blink_caps = ok and blink.get_lsp_capabilities() or {}

-- Servers are installed by mason but its bin directory only lands on PATH when
-- mason itself loads, which is lazy. Adding it here keeps LSP startup independent
-- of when that happens.
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

local servers = {
	"lua_ls",
	"clangd",
	"gopls",
	"rust_analyzer",
	"neocmake",
	"eslint",
	"gdscript",
	"vtsls",
	"bashls",
	"jsonls",
	"yamlls",
	"tailwindcss",
}

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
-- Generic keymaps
--------------------------------------------------------------------------------

local function on_attach(client, bufnr)
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

	-- Only one client per buffer should own formatting; conform.nvim drives it and
	-- falls back to whichever LSP still advertises the capability.
	if client.name == "vtsls" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		map("n", "<leader>co", function()
			require("utils.lsp").organize_imports()
		end, "Organize imports")
	end

	if client.name == "clangd" then
		map("n", "<leader>oh", function()
			require("utils.lsp").switch_source_header(client, bufnr)
		end, "Switch header/source")
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			on_attach(client, args.buf)
		end
	end,
})

--------------------------------------------------------------------------------
-- Global LSP keymaps
--------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set loclist" })

vim.keymap.set("n", "<leader>th", function()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

vim.lsp.enable(servers)
