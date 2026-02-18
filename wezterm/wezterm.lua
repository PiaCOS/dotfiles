-- ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'

local config = {}

-- ----------------------------------------------------
--                     FONT STUFF
-- ----------------------------------------------------

local FONT_FAMILY = "Maple Mono NF"
local FONT_SIZE = 9.5

-- local FONT_FAMILY = "Comic Mono"
-- local FONT_SIZE = 10.5

-- local FONT_FAMILY = "Cozette"
-- local FONT_SIZE = 12

config.font_size = FONT_SIZE
config.font = wezterm.font(FONT_FAMILY)

-- ----------------------------------------------------
--                      STYLING
-- ----------------------------------------------------

config.enable_tab_bar = false
config.window_background_opacity = 0.95
config.color_schemes = {}
config.color_scheme = 'Andromeda'
-- config.color_scheme = 'rose-pine'
-- config.color_scheme = 'Chameleon'
-- config.color_scheme = 'jubi'
-- config.color_scheme = 'BlueBerryPie'
-- config.color_scheme = 'Dark Violet (base16)'
-- config.color_scheme = 'matrix'
-- config.color_scheme = 'HaX0R_R3D'
-- config.colors = {
--     background = "#000000",
-- }

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
