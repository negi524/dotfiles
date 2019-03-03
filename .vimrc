set number                                      "行番号を表示
set showmatch                                   "括弧入力時の対応する括弧を表示
set matchtime=1                                 "対応括弧に飛ぶ時間を0.1x1秒に設定
set title                                       "ファイル名を表示
syntax on                                       "シンタックスハイライト
au BufRead,BufNewFile *.scss set filetype=sass  "scssのシンタックスハイライト
set pumheight=10                                "補完メニューの高さ
syntax enable                                   "構文チェック
set tabstop=2                                   "タブの文字幅
set shiftwidth=2                                "自動インデントの幅
set expandtab                                   "タブ入力を空白にする
set list                                        "listオプションを有効にする
set listchars=tab:»-,trail:-,nbsp:%
colorscheme murphy                              "配色を指定
