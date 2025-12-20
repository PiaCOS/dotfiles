-- ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'

local config = {}

-- ----------------------------------------------------
--                     FONT STUFF
-- ----------------------------------------------------

local FONT_FAMILY = "Maple Mono NF"
local FONT_SIZE = 9.5

config.font_size = FONT_SIZE
config.font = wezterm.font(FONT_FAMILY)

-- ----------------------------------------------------
--                      STYLING
-- ----------------------------------------------------

config.window_background_opacity = 0.89

config.enable_tab_bar = false
-- Define a custom scheme with Pastel Red text and Soft Black background
config.color_schemes = {
}
-- config.color_scheme = 'Andromeda'
-- config.color_scheme = 'rose-pine-moon'
config.color_scheme = 'Seoul256 (Gogh)'
-- config.color_scheme = 'Atelier Plateau (base16)'
config.colors = {
  -- foreground = "#756d6d",
  foreground = "#d5cdcd",
  background = "222222",
}
-- ----------------------------------------------------
--                       UTILS
-- ----------------------------------------------------

config.default_prog = { "/usr/bin/fish" }

config.keys = {
  -- was conflicting with lazygit commit keymap
  {
    key = 'Enter',
    mods = 'ALT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- ----------------------------------------------------

return config
