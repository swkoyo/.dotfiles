local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "tokyonight_night"
config.colors = {
	background = "#121212",
}

config.window_background_opacity = 0.9

config.hide_tab_bar_if_only_one_tab = true

config.font_size = 11

config.window_padding = {
	left = 5,
	right = 5,
	top = 2,
	bottom = 2,
}

config.font = wezterm.font({
	family = "Source Code Pro",
})

return config
