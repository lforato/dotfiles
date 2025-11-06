local keymap = require("helpers.keymap")
local fidget = require("fidget")

--------------------------------------------------------------------------------
-- Toggle
--------------------------------------------------------------------------------

-- Toggle git blame
keymap("n", "<leader>tb", function()
	vim.cmd(":Gitsigns blame_line")
	fidget.notify("Toggled Git Blame", vim.log.levels.SUCESS)
end)

-- Toggle explorer
keymap("n", "<leader>e", ":NvimTreeToggle<cr>")

keymap("n", "<leader>e", ":NvimTreeToggle<cr>")

-- Toggle comments in normal mode
keymap("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end)

-- Toggle comments in visual mode
keymap("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- Toggle trouble
keymap("n", "<leader>tt", function()
	require("trouble").focus("diagnostics")
end)

keymap("n", "tt", function()
	require("trouble").focus("diagnostics")
end)

--------------------------------------------------------------------------------
-- Controlling files ands buffers
--------------------------------------------------------------------------------

-- Save file
keymap("n", "<leader>fs", function()
	fidget.notify("Saving file...", vim.log.levels.SUCCESS)
	vim.cmd(":w!")
	fidget.notify("Saved file.", vim.log.levels.SUCCESS)
end)

-- Save and close file
keymap("n", "<leader>w", function()
	fidget.notify("Saving file...", vim.log.levels.SUCCESS)
	vim.cmd(":w")
	vim.cmd(":bdelete!")
	fidget.notify("Saved file.", vim.log.levels.SUCCESS)
end)

-- Close file
keymap("n", "<leader>x", ":bdelete!<cr>")

-- Buffers
keymap({ "n", "v" }, "<leader>,", function()
	vim.cmd(":BufferPrevious")
end)
keymap({ "n", "v" }, "<leader>.", function()
	vim.cmd(":BufferNext")
end)

-- Open current file in finder
keymap("n", "<leader>fb", ":Rfinder<cr>")

--------------------------------------------------------------------------------
-- Searching
--------------------------------------------------------------------------------

-- Telescope
local builtin = require("telescope.builtin")
keymap("n", "<leader>ff", builtin.find_files)
keymap("n", "<leader>fg", builtin.git_files)

keymap("n", "<leader>fw", builtin.live_grep)
keymap("n", "<leader>fr", builtin.resume)

-- Projects
keymap("n", "<C-p>", ":Telescope projects<cr>")

--------------------------------------------------------------------------------
-- Coding utilities
--------------------------------------------------------------------------------

-- Indentation
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Diagnostics
keymap("n", "<leader>cf", function()
	vim.diagnostic.open_float({ border = "rounded" })
end)

-- Moving Highlighting text
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Maintain cursor in the center when going to next
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Better undo
keymap("n", "U", ":redo<CR>")

-- Refactor
keymap("n", "<leader>tr", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})
