return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luacheckrc", ".stylua.toml" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "love2d", "love" },
			},
			workspace = {
				telemetry = { enable = false },
				checkThirdParty = false,
				library = {
					"${3rd}/love2d/library",
					".",
				},
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}
