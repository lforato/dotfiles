return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { ".git", "package.json" },
	init_options = {
		provideFormatter = false,
	},
	-- Resolved lazily: SchemaStore is a lazy plugin and this file is read while
	-- vim.lsp.config() is being built, before it has loaded.
	before_init = function(_, config)
		config.settings.json.schemas = require("schemastore").json.schemas()
	end,
	settings = {
		json = {
			validate = { enable = true },
		},
	},
}
