-- ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'

local io = require 'io'
local os = require 'os'

local config = {}

-- ----------------------------------------------------
--                   NEW FUNCS
-- ----------------------------------------------------

-- wezterm.on('gui-startup', function(cmd)
--   -- Run a command silently in the background
--   wezterm.background_child_process { 'cat', '~/Dev/dotfiles/kan' }
-- end)

-- Open window in helix
wezterm.on('edit-scrollback', function(window, pane)
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

  local name = os.tmpname() .. ".fish"
  local f = io.open(name, 'w+')
  f:write(text)
  f:flush()
  f:close()

  window:perform_action(
    wezterm.action.SpawnCommandInNewTab {
      args = { 'hx', name .. ':99999999' },
    },
    pane
  )
end)

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
-- config.window_background_opacity = 0.85
-- config.color_scheme = "Ic Green Ppl (Gogh)"
-- config.color_scheme = "Cloud (terminal.sexy)"
config.color_scheme_dirs = { '~/Dev/dotfiles/wezterm/colors' }
config.color_scheme = "HelixDefault"
config.colors = {
    -- foreground = "#f8f9e8",
    background = "#1b1818",
    -- background = "#232a2e",
}

-- ----------------------------------------------------
--                       UTILS
-- ----------------------------------------------------

config.default_prog = { "/usr/bin/fish" }

config.keys = {
  -- was conflicting with lazygit commit keymap
  -- {
  --   key = 'Enter',
  --   mods = 'ALT',
  --   action = wezterm.action.DisableDefaultAssignment,
  -- },
  -- quick select but on every word
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelectArgs {
      label = 'copy word',
      patterns = { '\\S+' },
    },
  },
  -- open window in helix
  {
    key = 'Enter',
    -- mods = 'ALT|SHIFT',
    mods = 'ALT',
    action = wezterm.action.EmitEvent 'edit-scrollback',
  },
}

-- ----------------------------------------------------
-- ----------------------------------------------------
-- ----------------------------------------------------

return config
