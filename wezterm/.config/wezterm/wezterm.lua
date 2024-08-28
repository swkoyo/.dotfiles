local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "tokyonight_night"
config.colors = {
	background = "#121212",
}

config.window_background_opacity = 0.85

config.hide_tab_bar_if_only_one_tab = true

local is_macos = wezterm.target_triple:find("apple") ~= nil
if is_macos then
	config.font_size = 14
else
	config.font_size = 12
end

config.window_padding = {
	left = 5,
	right = 5,
	top = 2,
	bottom = 2,
}

config.font = wezterm.font_with_fallback({
	"Iosevka Term",
	"Iosevka Nerd Font Mono",
	"Maple Mono NF",
	"Fantasque Sans Mono",
	"Space Mono",
	"JetBrains Mono",
	"Noto Sans Mono",
})

return config
