-- 基本設定
vim.opt.number = true                             -- 行番号を表示
vim.opt.title = true                              -- ファイル名を表示
vim.opt.smartcase = true                          -- 小文字で検索時、大文字小文字を無視する
vim.opt.wrap = false                              -- 行の折返しを無効にする

-- 括弧
vim.opt.showmatch = true                          -- 括弧入力時の対応する括弧を表示
vim.opt.matchtime = 1                             -- 対応括弧に飛ぶ時間を0.1×1秒に設定

-- タブ、インデント
vim.opt.tabstop = 2                               -- タブの文字幅
vim.opt.shiftwidth = 2                            -- 自動インデントの幅
vim.opt.smartindent = true                        -- 一つ前の行に基づくインデントを有効
vim.opt.expandtab = true                          -- タブ入力を空白にする
vim.opt.list = true                               -- listオプションを有効にする
vim.opt.listchars = { tab = '»-' , trail = '-' }  -- タブと行末空白を可視化する

-- ハイライト
vim.opt.hlsearch = true                           -- 検索ワードのハイライトを行う

-- netrw
vim.g.netrw_preview = 1                           -- プレビューウィンドウを垂直分割で表示する


-- カラースキーム

-- 対応括弧の色
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight MatchParen ctermfg=0 ctermbg=21 guifg=Black guibg=Blue1",
})

-- 行番号の色
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight LineNr ctermfg=lightmagenta",
})

-- コメントの色
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight Comment ctermfg=243",
})

-- 通常の文字色
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight Normal ctermfg=248",
})

-- ポップアップメニュー(通常の項目)
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight Pmenu ctermfg=232 ctermbg=255",
})

-- ポップアップメニュー(選択中の項目)
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight PmenuSel ctermfg=41 ctermbg=54",
})

-- ビジュアルモード選択
vim.api.nvim_create_autocmd({"ColorScheme"},{
  pattern = {"*"},
  command = "highlight Visual ctermbg=239",
})

vim.g.hybrid_custom_term_colors = 1               -- iTerm2用のhybrid設定
vim.cmd("colorscheme hybrid")

-- プラグイン
require('plugins')

vim.opt.helplang = 'ja,en'                        -- ヘルプの言語を日本語優先にする
