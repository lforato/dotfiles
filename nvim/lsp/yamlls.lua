return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = { ".git" },
	before_init = function(_, config)
		config.settings.yaml.schemas = require("schemastore").yaml.schemas()
	end,
	settings = {
		yaml = {
			validate = true,
			-- SchemaStore supplies the catalogue; the built-in store would fight it.
			schemaStore = {
				enable = false,
				url = "",
			},
		},
	},
}
