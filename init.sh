#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}

# hybridのデータをダウンロードする
echo "pwd : $(pwd)"
echo "git clone git@github.com:w0ng/vim-hybrid.git ${DOTPATH}/downloads/vim-hybrid"
echo "cp ${DOTPATH}/downloads/vim-hybrid/colors/hybrid.vim ${DOTPATH}/.vim/colors/"

exit 0
