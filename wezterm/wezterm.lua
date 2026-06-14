local wezterm = require 'wezterm'

-- -------- FONTS --------
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
config.font_size = FONT_SIZE
config.font = wezterm.font(FONT_FAMILY)

-- -------- THEME --------
-- config.window_background_opacity = 0.95
config.window_background_opacity = 1
config.enable_tab_bar = false
config.color_schemes = {}
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.colors = {
  -- background = "#000000",
}

-- -------- SHELL --------
config.default_prog = { "fish" }

-- -------- KEYS --------
config.keys = {
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

