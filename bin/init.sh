#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}

# カラースキームのデータをダウンロードする
function download_vim_color() {
  # hybridのカラースキームをダウンロードする
  if [ ! -f ${DOTPATH}/.vim/colors/hybrid.vim ]; then
    wget https://raw.githubusercontent.com/w0ng/vim-hybrid/master/colors/hybrid.vim -P ${DOTPATH}/.vim/colors/
  fi
}

# main関数
function main () {
  # vimのカラースキームをダウンロード
  download_vim_color
}

main

exit 0
