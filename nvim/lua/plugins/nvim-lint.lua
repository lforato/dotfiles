return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			cmake = { "cmakelint" },
		}

		local group = vim.api.nvim_create_augroup("user_nvim_lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = group,
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
