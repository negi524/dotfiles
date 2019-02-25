#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}

ln -sf ${DOTPATH}/.vimrc ${HOME}/.vimrc
echo "symbolic link: ${HOME}/.vimrc -> ${DOTPATH}/.vimrc"

ln -sf ${DOTPATH}/.bash_profile ${HOME}/.bash_profile
echo "symbolic link: ${HOME}/.bash_profile -> ${DOTPATH}/.bash_profile"

# fishの設定ディレクトリがある場合のみシンボリックリンクを作成する
if [ -d ${HOME}/.config/fish ]; then
  ln -sf ${DOTPATH}/.config/fish/config.fish ${HOME}/.config/fish/config.fish
  echo "symbolic link: ${HOME}/.config/fish/config.fish -> ${DOTPATH}/.config/fish/config.fish"
else
  echo "No such directory: ${HOME}/.cofig/fish"
fi

exit 0
