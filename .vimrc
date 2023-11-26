"プラグイン設定
call plug#begin('~/.vim/plugged')
Plug 'vim-jp/vimdoc-ja'
Plug 'tpope/vim-fugitive'
Plug 'posva/vim-vue'
Plug 'tyru/current-func-info.vim'
Plug 'w0ng/vim-hybrid'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
call plug#end()

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
let &statusline .= ' [%{cfi#format("%s", "")}]' " 関数名表示
set statusline+=%r                              " 読み込み専用かどうかを表示
set statusline+=%=                              " これ以降は右寄せ表示
set statusline+=[BF=%n]                         " バッファ番号
set statusline+=[LOW=%l/%L]                     " 現在行数/全行数
set statusline+=%y                              " ファイルタイプ表示

" ハイライト
set hlsearch                                    " 検索ワードのハイライトを行う
syntax on                                       "シンタックスハイライト
au BufRead,BufNewFile *.scss set filetype=sass  "scssのシンタックスハイライト
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact " TypeScriptのシンタックスハイライト
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

" カラースキーム設定
" 対応括弧の色
autocmd ColorScheme * highlight MatchParen ctermfg=0 ctermbg=21 guifg=Black guibg=Blue1
" 行番号の色
autocmd ColorScheme * highlight LineNr ctermfg=lightmagenta
" コメント
autocmd ColorScheme * highlight Comment ctermfg=243
" 通常の文字
autocmd ColorScheme * highlight Normal ctermfg=248
" ポップアップメニュー(通常の項目)
autocmd ColorScheme * highlight Pmenu ctermfg=232 ctermbg=255
" ポップアップメニュー(選択されている項目)
autocmd ColorScheme * highlight PmenuSel ctermfg=41 ctermbg=54
" ビジュアルモード選択
autocmd ColorScheme * highlight Visual ctermbg=239
let g:hybrid_custom_term_colors = 1             "iTerm2用のhybrid設定
colorscheme hybrid

" プラグイン設定
filetype plugin on                              "ftpluginによるファイルタイプの検出とプラグインを有効にする

"set tags=./tags;~/tags                          "カレントディレクトリからホームディレクトリまで検索する
set tags=./tags,tags,~/dotfiles/tmp/tags        "dotfiles内のタグも検索対象に含める

" タグを生成するコマンドのエイリアスを設定する
" タグの生成場所は~/dotfiles/tmp/tags
:command Maketag !ctags -Rf ~/dotfiles/tmp/tags --exclude=.git --tag-relative
