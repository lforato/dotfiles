--------------------------------------------------------------------------------
-- Incremental selection
--------------------------------------------------------------------------------

-- The nvim-treesitter rewrite dropped its incremental_selection module, so this
-- reimplements grow/shrink against the core vim.treesitter API. The visited
-- nodes are kept on a per-buffer stack so shrinking retraces exactly the path
-- growing took, rather than re-deriving a node from the visual range.

local M = {}

local stacks = {}

vim.api.nvim_create_autocmd({ "BufUnload", "InsertEnter" }, {
	group = vim.api.nvim_create_augroup("user_incsel", { clear = true }),
	callback = function(args)
		stacks[args.buf] = nil
	end,
})

local function in_visual()
	local mode = vim.fn.mode()
	return mode == "v" or mode == "V" or mode == "\22"
end

local function same_range(a, b)
	local a1, a2, a3, a4 = a:range()
	local b1, b2, b3, b4 = b:range()
	return a1 == b1 and a2 == b2 and a3 == b3 and a4 == b4
end

local function select_node(node)
	local srow, scol, erow, ecol = node:range()

	-- Treesitter end columns are exclusive and may land on column 0 of the line
	-- after the node; visual mode needs an inclusive position on the real line.
	if ecol == 0 and erow > srow then
		erow = erow - 1
		ecol = #vim.api.nvim_buf_get_lines(0, erow, erow + 1, true)[1]
	end

	-- `v` toggles, so issuing it while a selection is already active would leave
	-- visual mode instead of restarting the selection.
	if in_visual() then
		vim.cmd("normal! \27")
	end

	vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
	vim.cmd("normal! v")
	vim.api.nvim_win_set_cursor(0, { erow + 1, math.max(ecol - 1, 0) })
end

function M.grow()
	local buf = vim.api.nvim_get_current_buf()
	if not pcall(vim.treesitter.get_parser, buf) then
		return
	end

	local stack = stacks[buf]

	-- Starting fresh whenever we are not already extending a selection keeps the
	-- stack from going stale after the cursor moves on its own.
	if not in_visual() or not stack or #stack == 0 then
		local node = vim.treesitter.get_node({ bufnr = buf })
		if not node then
			return
		end
		stacks[buf] = { node }
		select_node(node)
		return
	end

	local current = stack[#stack]
	local parent = current:parent()

	-- Parents that span the same range would look like a no-op to the user.
	while parent and same_range(parent, current) do
		parent = parent:parent()
	end

	if not parent then
		select_node(current)
		return
	end

	stack[#stack + 1] = parent
	select_node(parent)
end

function M.shrink()
	local buf = vim.api.nvim_get_current_buf()
	local stack = stacks[buf]
	if not stack or #stack < 2 then
		return
	end

	stack[#stack] = nil
	select_node(stack[#stack])
end

return M
