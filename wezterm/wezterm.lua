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
config.window_background_opacity = 0.89
config.color_schemes = {}
config.colors = {
    foreground = "#f8f9e8",
    background = "#2b3438",
    -- background = "#232a2e",

    cursor_bg = "#cbe3b3",
    cursor_fg = "#171c1f",
    cursor_border = "#cbe3b3",

    selection_fg = "#f8f9e8",
    selection_bg = "#374145",

    scrollbar_thumb = "#2b3337",

    ansi = {
      -- "#232a2e", -- black
      "#f8f9e8", -- black2
      "#f57f82", -- red
      "#cbe3b3", -- green
      "#f5d098", -- yellow
      "#b2caed", -- blue
      "#f3c0e5", -- magenta
      "#b3e3ca", -- cyan
      "#f8f9e8", -- white
    },
    brights = {
      -- "#2b3337", -- black
      "#96b4aa", -- black2
      "#f57f82", -- red
      "#cbe3b3", -- green
      "#f5d098", -- yellow
      "#b2caed", -- blue
      "#f3c0e5", -- magenta
      "#b3e3ca", -- cyan
      "#96b4aa", -- white
    },

    indexed = {
      [16] = "#f7a182", -- search match accent
    },
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
