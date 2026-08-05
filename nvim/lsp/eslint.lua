return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	-- Root is wherever the eslint config lives, and without one the server must not
	-- attach at all: in single-file mode it fails every request.
	root_markers = {
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",
		"eslint.config.ts",
		"eslint.config.mts",
		"eslint.config.cts",
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.json",
		".eslintrc.yaml",
		".eslintrc.yml",
	},
	workspace_required = true,
	-- The server derives config lookup from workspaceFolder and fails every
	-- textDocument/diagnostic with "path must be of type string" without it.
	before_init = function(_, config)
		if not config.root_dir then
			return
		end

		config.settings.workspaceFolder = {
			uri = vim.uri_from_fname(config.root_dir),
			name = vim.fn.fnamemodify(config.root_dir, ":t"),
		}
	end,
	handlers = {
		-- The server refuses to lint until the client approves execution, and it
		-- fails silently rather than erroring, so omitting this looks like eslint
		-- simply having no opinion about the file. 4 = approved.
		["eslint/confirmESLintExecution"] = function(_, result)
			if not result then
				return
			end
			return 4
		end,
		["eslint/openDoc"] = function(_, result)
			if result then
				vim.ui.open(result.url)
			end
			return {}
		end,
		["eslint/probeFailed"] = function()
			vim.notify("eslint: probe failed", vim.log.levels.WARN)
			return {}
		end,
		["eslint/noLibrary"] = function()
			vim.notify("eslint: unable to find the ESLint library", vim.log.levels.WARN)
			return {}
		end,
	},
	-- The server dereferences most of these unconditionally; a missing table fails
	-- requests with "Cannot read properties of undefined".
	settings = {
		validate = "on",
		useESLintClass = false,
		experimental = {},
		codeActionOnSave = {
			enable = false,
			mode = "all",
		},
		-- prettier owns formatting through conform; letting eslint format too is how
		-- save-loops start fighting each other.
		format = false,
		quiet = false,
		onIgnoredFiles = "off",
		rulesCustomizations = {},
		run = "onType",
		problems = {
			shortenToSingleLine = false,
		},
		nodePath = "",
		-- "auto" resolves the nearest package dir, which is what a pnpm workspace
		-- with per-package configs needs.
		workingDirectory = { mode = "auto" },
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine",
			},
			showDocumentation = {
				enable = true,
			},
		},
	},
}
