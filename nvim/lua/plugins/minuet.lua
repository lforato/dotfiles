-- minuet raises "Anthropic API key is not set" on every completion attempt when
-- the key is missing, so it stays switched off entirely rather than erroring on
-- each InsertEnter. blink.lua drops the matching source the same way.
local has_api_key = vim.env.ANTHROPIC_API_KEY ~= nil and vim.env.ANTHROPIC_API_KEY ~= ""

return {
	"milanglacier/minuet-ai.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "InsertEnter",
	cond = has_api_key,
	opts = {
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
	},
}
