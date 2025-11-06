vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luacheckrc", ".stylua.toml" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
        telemetry = { enable = false },
        checkThirdParty = false,
        library = {
          "${3rd}/love2d/library",
        },
      },
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

vim.lsp.enable("lua_ls")
