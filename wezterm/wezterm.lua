-- ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'

local config = {}

local FONT_FAMILY = "Maple Mono NF"
local FONT_SIZE = 9.5

config.font_size = FONT_SIZE

config.enable_tab_bar = false

config.default_prog = { "/usr/bin/fish" }

-- config.color_scheme = "Catppuccin Macchiato"
config.color_scheme = 'rose-pine'
config.keys = {
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}
return config
