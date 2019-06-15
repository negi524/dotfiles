#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}

# main関数
function main () {
  # hybridのデータをダウンロードする
  if [ ! -d ${DOTPATH}/downloads/vim-hybrid-master ]; then
    wget https://github.com/w0ng/vim-hybrid/archive/master.zip -P ${DOTPATH}/downloads/
    unzip ${DOTPATH}/downloads/master.zip -d ${DOTPATH}/downloads/
  fi

  if [ ! -f ${DOTPATH}/.vim/colors/hybrid.vim ]; then
    cp ${DOTPATH}/downloads/vim-hybrid-master/colors/hybrid.vim ${DOTPATH}/.vim/colors/
  fi
}

main

exit 0
