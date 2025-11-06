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
