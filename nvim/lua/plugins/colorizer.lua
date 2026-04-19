return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({ "*" }, { mode = "background" })
	end,
}
