return {
	"saghen/blink.cmp",
	dependencies = { { "rafamadriz/friendly-snippets" }, { "L3MON4D3/LuaSnip", version = "v2.*" } },
	version = "1.*",
	enabled = true,

	opts = {

		snippets = { preset = "luasnip" },

		keymap = {
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev" },
			["<CR>"] = { "accept", "fallback" },
			["<C-k>"] = { "show_signature" },
		},

		appearance = {
			highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
			nerd_font_variant = "mono",
		},
		signature = {
			enabled = true,
			trigger = {
				enabled = true,
				show_on_keyword = false,
				blocked_trigger_characters = {},
				blocked_retrigger_characters = {},
				show_on_trigger_character = true,
				show_on_insert = false,
				show_on_insert_on_trigger_character = true,
			},
			window = {
				min_width = 1,
				max_width = 100,
				max_height = 10,
				winblend = 0,
				winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				border = "rounded",
				scrollbar = false,
				direction_priority = { "n", "s" },
				treesitter_highlighting = true,
				show_documentation = true,
			},
		},
		completion = {
			menu = {
				border = "rounded",
			},
			documentation = {
				auto_show = true,
				treesitter_highlighting = true,
				draw = function(opts)
					opts.default_implementation()
				end,
				window = {
					min_width = 10,
					max_width = 80,
					max_height = 20,
					winblend = 0,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					border = "rounded",
					scrollbar = true,
					direction_priority = {
						menu_north = { "e", "w", "n", "s" },
						menu_south = { "e", "w", "s", "n" },
					},
				},
			},
		},
		sources = { default = { "lsp", "path", "snippets", "buffer" } },
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},

	opts_extend = { "sources.default" },
}
