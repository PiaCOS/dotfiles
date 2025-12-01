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

config.enable_tab_bar = false
-- Define a custom scheme with Pastel Red text and Soft Black background
config.color_schemes = {
  ['Magma'] = {
    foreground = '#F06060',
    background = '#101014',

    ansi = {
      '#101014', -- Black (Soft Black)
      '#F04040', -- Red (Light Coral/Pastel Red)
      '#A0D4B2', -- Green (Soft Mint)
      '#FFCC99', -- Yellow (Soft Peach)
      '#B0C4DE', -- Blue (Soft Slate)
      '#E6A8D7', -- Magenta (Soft Pink)
      '#ADD8E6', -- Cyan (Soft Blue)
      '#D3D3D3', -- White (Light Grey)
    },

    brights = {
      '#444444', -- Bright Black (Dark Grey)
      '#FFB6C1', -- Bright Red (Light Pink/More Pastel)
      '#C1E1C1', -- Bright Green
      '#FFDDAA', -- Bright Yellow
      '#C6E2FF', -- Bright Blue
      '#FBAED2', -- Bright Magenta
      '#B0E0E6', -- Bright Cyan
      '#F07F7F', -- Bright White (True White)
    },

    cursor_bg = '#F08080',
    cursor_fg = '#181818',
  }
}
-- config.color_scheme = 'Magma'
config.color_scheme = 'rose-pine'
-- config.color_scheme = 'Count Von Count (terminal.sexy)'

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
