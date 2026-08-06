local function select(obj)
	return function()
		require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
	end
end

local function move(fn, obj)
	return function()
		require("nvim-treesitter-textobjects.move")[fn](obj, "textobjects")
	end
end

local function swap(fn, obj)
	return function()
		require("nvim-treesitter-textobjects.swap")[fn](obj)
	end
end

return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	keys = {
		{ "aa", select("@parameter.outer"), mode = { "x", "o" }, desc = "Select parameter (outer)" },
		{ "ia", select("@parameter.inner"), mode = { "x", "o" }, desc = "Select parameter (inner)" },
		{ "af", select("@function.outer"), mode = { "x", "o" }, desc = "Select function (outer)" },
		{ "if", select("@function.inner"), mode = { "x", "o" }, desc = "Select function (inner)" },
		{ "ac", select("@class.outer"), mode = { "x", "o" }, desc = "Select class (outer)" },
		{ "ic", select("@class.inner"), mode = { "x", "o" }, desc = "Select class (inner)" },

		{ "]m", move("goto_next_start", "@function.outer"), mode = { "n", "x", "o" }, desc = "Next function start" },
		{ "]M", move("goto_next_end", "@function.outer"), mode = { "n", "x", "o" }, desc = "Next function end" },
		{
			"[m",
			move("goto_previous_start", "@function.outer"),
			mode = { "n", "x", "o" },
			desc = "Previous function start",
		},
		{
			"[M",
			move("goto_previous_end", "@function.outer"),
			mode = { "n", "x", "o" },
			desc = "Previous function end",
		},
		{ "]]", move("goto_next_start", "@class.outer"), mode = { "n", "x", "o" }, desc = "Next class start" },
		{ "][", move("goto_next_end", "@class.outer"), mode = { "n", "x", "o" }, desc = "Next class end" },
		{ "[[", move("goto_previous_start", "@class.outer"), mode = { "n", "x", "o" }, desc = "Previous class start" },
		{ "[]", move("goto_previous_end", "@class.outer"), mode = { "n", "x", "o" }, desc = "Previous class end" },

		{ "]a", swap("swap_next", "@parameter.inner"), desc = "Swap parameter with next" },
		{ "[a", swap("swap_previous", "@parameter.inner"), desc = "Swap parameter with previous" },
	},
	opts = {
		select = {
			lookahead = true,
		},
		move = {
			set_jumps = true,
		},
	},
}
