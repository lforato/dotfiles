-- vtsls consumes VS Code's settings schema, so these keys are the VS Code names
-- (importModuleSpecifier, not importModuleSpecifierPreference).
local preferences = {
	importModuleSpecifier = "non-relative",
	quoteStyle = "auto",
}

local inlay_hints = {
	parameterNames = { enabled = "all" },
	parameterTypes = { enabled = true },
	variableTypes = { enabled = true },
	propertyDeclarationTypes = { enabled = true },
	functionLikeReturnTypes = { enabled = true },
	enumMemberValues = { enabled = true },
}

return {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
	settings = {
		vtsls = {
			-- Resolves the tsconfig for the package owning the file instead of
			-- starting a server per workspace package.
			autoUseWorkspaceTsdk = true,
			enableMoveToFileCodeAction = true,
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		typescript = {
			preferences = preferences,
			inlayHints = inlay_hints,
			updateImportsOnFileMove = { enabled = "always" },
			suggest = { completeFunctionCalls = true },
		},
		javascript = {
			preferences = preferences,
			inlayHints = inlay_hints,
			updateImportsOnFileMove = { enabled = "always" },
		},
	},
}
