#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}

# hybridのデータをダウンロードする
if [ ! -d ${DOTPATH}/downloads/vim-hybrid ]; then
  git clone git@github.com:w0ng/vim-hybrid.git ${DOTPATH}/downloads/vim-hybrid
fi
cp ${DOTPATH}/downloads/vim-hybrid/colors/hybrid.vim ${DOTPATH}/.vim/colors/

exit 0
