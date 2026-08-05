local parsers = {
	"bash",
	"c",
	"cmake",
	"cpp",
	"css",
	"diff",
	"gdscript",
	"gdshader",
	"git_config",
	"gitcommit",
	"go",
	"gomod",
	"gowork",
	"html",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"rust",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{
			"<c-space>",
			function()
				require("utils.incsel").grow()
			end,
			mode = { "n", "x" },
			desc = "Expand selection to parent node",
		},
		{
			"<M-space>",
			function()
				require("utils.incsel").shrink()
			end,
			mode = "x",
			desc = "Shrink selection to child node",
		},
	},
	config = function()
		-- The main branch has no highlight/indent modules; both are core APIs that
		-- have to be turned on per buffer. Anything without a parser is skipped.
		local function enable(buf)
			if not pcall(vim.treesitter.start, buf) then
				return
			end
			vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
			callback = function(args)
				enable(args.buf)
			end,
		})

		-- This plugin loads on BufReadPost, by which point FileType has already
		-- fired for the buffer that triggered it.
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) then
				enable(buf)
			end
		end

		-- install() compiles via the tree-sitter CLI, so only ask for what is
		-- actually missing instead of paying that cost on every startup.
		local missing = vim.tbl_filter(function(lang)
			return not pcall(vim.treesitter.language.inspect, lang)
		end, parsers)

		if #missing > 0 then
			require("nvim-treesitter").install(missing)
		end
	end,
}
