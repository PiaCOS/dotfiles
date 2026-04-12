-- ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'

local config = {}

-- ----------------------------------------------------
--                     FONT STUFF
-- ----------------------------------------------------

local FONT_FAMILY = "Maple Mono NF"
local FONT_SIZE = 11

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
-- config.window_background_opacity = 0.85
-- config.color_scheme = 'PaperColor Dark (base16)'
config.color_scheme = 'Sonokai (Gogh)'
-- config.color_scheme = 'Tokyo Night'

config.colors = {
    -- foreground = "#f8f9e8",
    -- background = "#1b1818",
    -- background = "#232a2e",
}

-- ----------------------------------------------------
--                       UTILS
-- ----------------------------------------------------

config.default_prog = { "/opt/homebrew/bin/fish" }

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
