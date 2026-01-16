-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 15
config.color_scheme = 'One Half Black (Gogh)'


-- keybinds
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }

-- ステータスバーにワークスペース名を表示
wezterm.on('update-right-status', function(window, pane)
  local workspace = window:active_workspace()
  window:set_right_status(wezterm.format {
    { Foreground = { Color = '#8be9fd' } },
    { Text = ' 󰖯 ' .. workspace .. ' ' },
  })
end)

-- Finally, return the configuration to wezterm:
return config
