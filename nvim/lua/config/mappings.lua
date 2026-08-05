local keymap = require("utils.keymap")

--------------------------------------------------------------------------------
-- Toggle
--------------------------------------------------------------------------------

-- Wraps Nvim's built-in gc operator, so remap has to stay on.
keymap("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
keymap("x", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

keymap("n", "<leader>tt", function()
	require("trouble").focus("diagnostics")
end, { desc = "Toggle Trouble" })

keymap("n", "<leader>te", "<cmd>EslintToggle<cr>", { desc = "Toggle ESLint" })

--------------------------------------------------------------------------------
-- Files and buffers
--------------------------------------------------------------------------------

keymap("n", "<leader>fs", "<cmd>w!<cr>", { desc = "Save file" })
keymap("n", "<leader>w", "<cmd>w<bar>bdelete!<cr>", { desc = "Save and close buffer" })
keymap("n", "<leader>x", "<cmd>bdelete!<cr>", { desc = "Close buffer" })

keymap({ "n", "v" }, "<leader>,", "<cmd>BufferPrevious<cr>", { desc = "Previous buffer" })
keymap({ "n", "v" }, "<leader>.", "<cmd>BufferNext<cr>", { desc = "Next buffer" })

keymap("n", "<leader>fb", "<cmd>Rfinder<cr>", { desc = "Reveal in Finder" })

--------------------------------------------------------------------------------
-- Coding utilities
--------------------------------------------------------------------------------

keymap("v", "<", "<gv", { desc = "Indent left, keep selection" })
keymap("v", ">", ">gv", { desc = "Indent right, keep selection" })

keymap("n", "<leader>cf", function()
	vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Code floating diagnostics" })

keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

keymap("n", "n", "nzzzv", { desc = "Next search, centered" })
keymap("n", "N", "Nzzzv", { desc = "Prev search, centered" })

keymap("n", "U", "<cmd>redo<cr>", { desc = "Redo" })
