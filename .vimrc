"プラグイン設定
call plug#begin('~/.vim/plugged')
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-fugitive'
Plug 'posva/vim-vue'
call plug#end()

" 基本
set helplang=ja,en                              "ヘルプの言語を日本語優先にする
set number                                      "行番号を表示
set title                                       "ファイル名を表示
set pumheight=10                                "補完メニューの高さ
set smartcase                                   "小文字で検索時、大文字小文字を無視する

" 括弧
set showmatch                                   "括弧入力時の対応する括弧を表示
set matchtime=1                                 "対応括弧に飛ぶ時間を0.1x1秒に設定

" ハイライト
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

" カラースキーム設定
autocmd ColorScheme * highlight MatchParen ctermfg=0 ctermbg=21 guifg=Black guibg=Blue1
let g:hybrid_custom_term_colors = 1             "iTerm2用のhybrid設定
colorscheme hybrid

" プラグイン設定
filetype plugin on                              "ftpluginによるファイルタイプの検出とプラグインを有効にする

"set tags=./tags;~/tags                          "カレントディレクトリからホームディレクトリまで検索する
set tags=./tags,tags,~/dotfiles/tmp/tags        "dotfiles内のタグも検索対象に含める

" タグを生成するコマンドのエイリアスを設定する
" タグの生成場所は~/dotfiles/tmp/tags
:command Maketag !ctags -Rf ~/dotfiles/tmp/tags --exclude=.git --tag-relative
