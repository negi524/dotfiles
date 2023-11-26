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

-- 目印桁
vim.opt.signcolumn = 'yes'                        -- 目印桁を常に表示する


-- カラースキームの読み込みと設定
require('colors')

-- プラグイン設定
require('plugins')

vim.opt.helplang = 'ja,en'                        -- ヘルプの言語を日本語優先にする
