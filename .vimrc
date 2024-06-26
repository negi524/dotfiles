" 基本
set helplang=ja,en                              "ヘルプの言語を日本語優先にする
set number                                      "行番号を表示
set title                                       "ファイル名を表示
set pumheight=10                                "補完メニューの高さ
set smartcase                                   "小文字で検索時、大文字小文字を無視する
"set relativenumber                              " 行番号をカーソルからの相対指定にする
set nowrap                                      " 行の折り返しを無効にする

" 括弧
set showmatch                                   "括弧入力時の対応する括弧を表示
set matchtime=1                                 "対応括弧に飛ぶ時間を0.1x1秒に設定

" ステータスライン
set laststatus=2                                " ステータスラインを常に表示する
set statusline=%F                               " ファイル名表示
set statusline+=%r                              " 読み込み専用かどうかを表示
set statusline+=%=                              " これ以降は右寄せ表示
set statusline+=[BF=%n]                         " バッファ番号
set statusline+=[LOW=%l/%L]                     " 現在行数/全行数
set statusline+=%y                              " ファイルタイプ表示

" ハイライト
set hlsearch                                    " 検索ワードのハイライトを行う
syntax on                                       "シンタックスハイライト
au BufRead,BufNewFile *.scss set filetype=sass  "scssのシンタックスハイライト
syntax enable                                   "構文チェック

" タブ、インデント
set tabstop=2                                   "タブの文字幅
set shiftwidth=2                                "自動インデントの幅
set smartindent                                 "一つ前の行に基づくインデント
set expandtab                                   "タブ入力を空白にする
set list                                        "listオプションを有効にする
set listchars=tab:»-,trail:-,nbsp:%             "listオプションを設定する

" コマンドライン
" <C-p>, <C-n>でフィルタリングしながらコマンドラインの補完を行う
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
set wildmenu                                    "入力候補を表示する

" netrw
let g:netrw_preview=1                             " プレビューウィンドウを垂直分割で表示する

