local ok, dap = pcall(require, "dap")
if not ok then
	return
end

local js_debug = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = { js_debug, "${port}" },
	},
}

dap.adapters["pwa-chrome"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = { js_debug, "${port}" },
	},
}

local js_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

for _, lang in ipairs(js_languages) do
	dap.configurations[lang] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach to Node process",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			skipFiles = { "<node_internals>/**", "node_modules/**" },
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest test",
			runtimeExecutable = "node",
			runtimeArgs = { "./node_modules/jest/bin/jest.js", "--runInBand" },
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
		},
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Vitest test (current file)",
			runtimeExecutable = "node",
			runtimeArgs = { "./node_modules/vitest/vitest.mjs", "run", "${file}" },
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
			sourceMaps = true,
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Launch Chrome (localhost:3000)",
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			sourceMaps = true,
		},
	}
end
