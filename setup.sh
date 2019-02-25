#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}

ln -sf ${DOTPATH}/.vimrc ${HOME}/.vimrc
echo "symbolic link: ${HOME}/.vimrc -> ${DOTPATH}/.vimrc"

ln -sf ${DOTPATH}/.config/fish/config.fish ${HOME}/.config/fish/config.fish
echo "symbolic link: ${HOME}/.config/fish/config.fish -> ${DOTPATH}/.config/fish/config.fish"

ln -sf ${DOTPATH}/.bash_aliases ${HOME}/.bash_aliases
echo "symbolic link: ${HOME}/.bash_aliases -> ${DOTPATH}/.bash_aliases"

exit 0
