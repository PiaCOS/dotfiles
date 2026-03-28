local wezterm = require 'wezterm'
local config = {}

-- -------- FONTS --------
local FONT_FAMILY = "Maple Mono NF"
-- local FONT_FAMILY = "TamzenForPowerline"
local FONT_SIZE = 9.5
config.font_size = FONT_SIZE
config.font = wezterm.font(FONT_FAMILY)

-- -------- THEME --------
-- config.window_background_opacity = 0.6
config.window_background_opacity = 0.95
-- config.window_background_opacity = 1
config.enable_tab_bar = false
config.color_schemes = {}
-- config.color_scheme = 'Seoul256 (Gogh)'
-- config.color_scheme = 'Dark Violet (base16)'
config.color_scheme = 'Gruvbox Dark (Gogh)'
-- config.color_scheme = 'Github (base16)'
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
config.colors = {
  -- foreground = "#d5cdcd",
  -- background = "#999999",
  -- background = "#000000",
}

-- -------- SHELL --------
config.default_prog = { "fish" }

-- -------- KEYS --------
config.keys = {
  -- was conflicting with lazygit commit keymap
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config

