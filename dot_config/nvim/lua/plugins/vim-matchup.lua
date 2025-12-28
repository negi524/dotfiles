return {
  "andymass/vim-matchup",
  event = { "BufReadPost" },  -- ファイル読み込み後に遅延ロード
  config = function()
    -- === 可視化のみを有効化 ===
    -- 移動機能を無効化 (%キーは標準Vimの動作)
    vim.g.matchup_motion_enabled = 0

    -- テキストオブジェクト機能を無効化
    vim.g.matchup_text_obj_enabled = 0

    -- === パフォーマンス最適化 ===
    -- 非同期処理でカーソル移動の遅延を防止
    vim.g.matchup_matchparen_deferred = 1

    -- === 画面外マッチの表示 ===
    -- 対応タグが画面外の場合、ポップアップで表示
    vim.g.matchup_matchparen_offscreen = {
      method = "popup",
      fullwidth = 1,
    }

    -- === ハイライトスタイルのカスタマイズ ===
    vim.api.nvim_set_hl(0, 'MatchParen', {
      underline = true,  -- 下線を引く
      bg = '#3e4451', -- 背景色を変更する場合
    })
  end,
}
