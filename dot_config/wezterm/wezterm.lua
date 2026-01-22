-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- 設定変更を即時反映する
config.automatically_reload_config = true

-- 初期ウィンドウサイズ
config.initial_cols = 160
config.initial_rows = 38

-- macOSのフルスクリーンモードは使わない
config.native_macos_fullscreen_mode = false

-- フォントサイズ
config.font_size = 15

-- 日本語IMEの設定
config.use_ime = true
config.macos_forward_to_ime_modifier_mask = 'SHIFT|CTRL'

-- カラースキーマ
config.color_scheme = 'OneHalfDark'

-- タイトルバー削除
config.window_decorations = "RESIZE"

-- タブバーの+ボタンを非表示
config.show_new_tab_button_in_tab_bar = false

-- フォントのフォールバック設定
-- https://wezterm.org/config/fonts.html
config.font = wezterm.font_with_fallback({
  -- デフォルト
  "JetBrains Mono",
  "Noto Color Emoji",
  "Symbols Nerd Font Mono",
  -- nvim-treeプラグイン用に追加
  "Hack Nerd Font"
})

-- keybinds
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }


-- ステータスバーにワークスペース名を表示
-- https://wezterm.org/config/lua/window-events/update-right-status.html
wezterm.on('update-right-status', function(window, pane)
  local workspaces = wezterm.mux:get_workspace_names()
  local current = window:active_workspace()

  local elements = {}
  for _, ws in ipairs(workspaces) do
    if ws == current then
      -- アクティブ: 緑 + アイコン
      table.insert(elements, { Foreground = { Color = '#98c379' } })
      table.insert(elements, { Text = ' 󰖯 ' .. ws })
    else
      -- 非アクティブ: グレー
      table.insert(elements, { Foreground = { Color = '#5c6370' } })
      table.insert(elements, { Text = '  ' .. ws })
    end
  end

  table.insert(elements, { Text = ' ' })
  window:set_right_status(wezterm.format(elements))
end)


-- ズーム状態を可視化
-- https://wezterm.org/config/lua/window-events/format-tab-title.html
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  if tab.active_pane.is_zoomed then
    return {
      { Foreground = { Color = 'yellow' } },
      { Text = '  ' .. title .. ' ' },
    }
  end

  return title
end)

-- Finally, return the configuration to wezterm:
return config
