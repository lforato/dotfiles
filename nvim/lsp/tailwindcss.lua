return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"css",
		"scss",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	-- Only attach inside packages that actually configure Tailwind, so a monorepo
	-- does not get a server per package that merely imports React.
	root_markers = {
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"tailwind.config.ts",
	},
	workspace_required = true,
	settings = {
		tailwindCSS = {
			validate = true,
			classAttributes = { "class", "className", "classList", "ngClass" },
		},
	},
}
