return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh", "zsh" },
	root_markers = { ".git" },
	settings = {
		bashIde = {
			-- shellcheck lives outside mason here; the server no-ops without it.
			shellcheckPath = "shellcheck",
		},
	},
}
