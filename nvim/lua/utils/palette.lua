--------------------------------------------------------------------------------
-- Colour palette
--------------------------------------------------------------------------------

-- Kept separate from the plugin spec in lua/plugins/theme.lua so that
-- lua/config/highlights.lua can read colours without pulling a lazy spec into
-- the startup path.

return {
	transparent = "NONE",
	bg0 = "#1D2021",
	bg1 = "#282828",
	bg3 = "#928374",
	bg5 = "#fbf1c7",

	primary = "#fe8019",
	secondary = "#b8bb26",

	light = "#ebdbb2",
	fg_dark = "#a89984",

	success = "#fe8019",
	success_fg = "#282828",
	error = "#fb4934",
	warning = "#fabd2f",
}
