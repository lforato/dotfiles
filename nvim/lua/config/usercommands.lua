--------------------------------------------------------------------------------
--- User Commands
--------------------------------------------------------------------------------

-- This autocmd is used to Restart LSP
vim.api.nvim_create_user_command("R", function()
	vim.api.nvim_command("LspRestart")
	print("LSP Restarted...")
end, {})

-- User Command to get the PATH of the current file
vim.api.nvim_create_user_command("Path", function()
	local current_file = vim.fn.expand("%:p")
	local root = vim.lsp.buf.list_workspace_folders()[1]
	if root == nil then
		root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	end
	local relative_path = vim.fn.fnamemodify(current_file, ":~:.")
	if root and relative_path:sub(1, #root) == root then
		relative_path = relative_path:sub(#root + 2)
	end
	vim.fn.setreg("+", relative_path)
	print("Copied path to clipboard: " .. relative_path)
end, {})

-- Close all buffers but current
vim.api.nvim_create_user_command("Close", function()
	vim.cmd("BufferCloseAllButCurrent")
end, {})

-- Referenced by <leader>fb, which had no command behind it.
vim.api.nvim_create_user_command("Rfinder", function()
	local file = vim.fn.expand("%:p")
	if file == "" then
		vim.notify("No file in this buffer", vim.log.levels.WARN)
		return
	end
	vim.system({ "open", "-R", file })
end, { desc = "Reveal current file in Finder" })

--------------------------------------------------------------------------------
--- ESLint
--------------------------------------------------------------------------------

local eslint_filetypes = {
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
}

-- vim.lsp.enable() only affects buffers opened afterwards, so already-open ones
-- have to be re-triggered by hand for the toggle to feel immediate.
local function reattach_eslint()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) and eslint_filetypes[vim.bo[bufnr].filetype] then
			vim.api.nvim_exec_autocmds("FileType", { buffer = bufnr, modeline = false })
		end
	end
end

local function eslint_enable()
	vim.lsp.enable("eslint")
	reattach_eslint()
	vim.notify("ESLint enabled", vim.log.levels.INFO)
end

local function eslint_disable()
	vim.lsp.enable("eslint", false)
	for _, client in ipairs(vim.lsp.get_clients({ name = "eslint" })) do
		client:stop(true)
	end
	vim.notify("ESLint disabled", vim.log.levels.INFO)
end

vim.api.nvim_create_user_command("EslintEnable", eslint_enable, { desc = "Enable ESLint LSP" })
vim.api.nvim_create_user_command("EslintDisable", eslint_disable, { desc = "Disable ESLint LSP" })

vim.api.nvim_create_user_command("EslintToggle", function()
	if #vim.lsp.get_clients({ name = "eslint" }) > 0 then
		eslint_disable()
	else
		eslint_enable()
	end
end, { desc = "Toggle ESLint LSP" })
