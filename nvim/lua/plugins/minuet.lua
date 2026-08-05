return {
	"milanglacier/minuet-ai.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("minuet").setup({
			provider = "claude",
			provider_options = {
				claude = {
					model = "claude-sonnet-5",
					max_tokens = 512,
					api_key = "ANTHROPIC_API_KEY",
					optional = {
						temperature = 0,
					},
				},
			},
			-- Suggestions render inside blink.cmp's own popup (configured in blink.lua)
			-- rather than as separate virtual-text ghost text.
			virtualtext = { auto_trigger_ftype = {} },
		})
	end,
}
