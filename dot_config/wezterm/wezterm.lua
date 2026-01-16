-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- フォントサイズ
config.font_size = 15
-- カラースキーマ
config.color_scheme = 'OneHalfDark'

-- タイトルバー削除
config.window_decorations = "RESIZE"

-- タブバーの+ボタンを非表示
config.show_new_tab_button_in_tab_bar = false

-- keybinds
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }

-- ステータスバーにワークスペース名を表示
wezterm.on('update-right-status', function(window, pane)
  local workspace = window:active_workspace()
  window:set_right_status(wezterm.format {
    { Foreground = { Color = '#98c379' } },
    { Text = ' 󰖯 ' .. workspace .. ' ' },
  })
end)

-- Finally, return the configuration to wezterm:
return config
