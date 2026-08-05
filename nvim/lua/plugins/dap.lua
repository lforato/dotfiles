return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		{ "<F5>", function() require("dap").continue() end, desc = "DAP: Continue" },
		{ "<F10>", function() require("dap").step_over() end, desc = "DAP: Step over" },
		{ "<F11>", function() require("dap").step_into() end, desc = "DAP: Step into" },
		{ "<F12>", function() require("dap").step_out() end, desc = "DAP: Step out" },
		{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
		{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "DAP: Conditional breakpoint" },
		{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP: Toggle REPL" },
		{ "<leader>dl", function() require("dap").run_last() end, desc = "DAP: Run last" },
		{ "<leader>du", function() require("dapui").toggle() end, desc = "DAP: Toggle UI" },
		{ "<leader>dt", function() require("dap").terminate() end, desc = "DAP: Terminate" },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			ensure_installed = { "codelldb" },
			automatic_installation = true,
			handlers = {},
		})

		dapui.setup()
		require("nvim-dap-virtual-text").setup({})

		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
		dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.exepath("codelldb"),
				args = { "--port", "${port}" },
			},
		}

		dap.adapters.godot = {
			type = "server",
			host = "127.0.0.1",
			port = 6006,
		}

		dap.configurations.gdscript = {
			{
				type = "godot",
				request = "launch",
				name = "Launch scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			},
		}

		for _, lang in ipairs({ "c", "cpp", "rust" }) do
			dap.configurations[lang] = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
		end

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo" })
	end,
}
