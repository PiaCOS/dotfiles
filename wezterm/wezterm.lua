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
  ["BooBerry"] = {
    foreground = '#C7B8E0', -- lilac
    background = '#3A2A4D', -- berry

    cursor_bg = '#C7B8E0', -- lilac
    cursor_fg = '#3A2A4D', -- berry
    cursor_border = '#C7B8E0',

    selection_fg = 'none',
    selection_bg = '#47345E', -- berry_dim (Used for selection for better contrast)

    scrollbar_thumb = '#5A3D6E', -- berry_fade
    split = '#47345E', -- berry_dim

    ansi = {
        '#2B1C3D', -- Black (berry_saturated)
        '#D678B5', -- Red (bubblegum)
        '#7FC9AB', -- Green (mint)
        '#E3C0A8', -- Yellow (gold)
        '#C78DFC', -- Blue (violet)
        '#D678B5', -- Magenta (bubblegum)
        '#7FC9AB', -- Cyan (mint)
        '#C7B8E0', -- White (lilac)
    },
    brights = {
        '#886C9C', -- Bright Black (berry_desaturated / comments)
        '#D678B5', -- Bright Red
        '#7FC9AB', -- Bright Green
        '#E3C0A8', -- Bright Yellow
        '#C78DFC', -- Bright Blue
        '#D678B5', -- Bright Magenta
        '#7FC9AB', -- Bright Cyan
        '#FFFFFF', -- Bright White (Boosted for contrast)
    },
    tab_bar = {
      background = '#2B1C3D', -- berry_saturated

      -- The active tab (matches ui.statusline.normal)
      active_tab = {
          bg_color = '#C7B8E0', -- lilac
          fg_color = '#2B1C3D', -- berry_saturated
      },

      -- Inactive tabs (matches ui.statusline.inactive)
      inactive_tab = {
          bg_color = '#2B1C3D', -- berry_saturated
          fg_color = '#886C9C', -- berry_desaturated
      },

      -- The "new tab" button
      new_tab = {
          bg_color = '#2B1C3D',
          fg_color = '#C7B8E0',
      },
    },
  }
}
-- config.color_scheme = 'BooBerry'
config.color_scheme = 'Andromeda'
-- config.color_scheme = 'nord'
-- config.color_scheme = 'rose-pine'
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
