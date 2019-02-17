#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}

ln -sf ${DOTPATH}/.vimrc ${HOME}/.vimrc
echo "symbolic link: ${HOME}/.vimrc -> ${DOTPATH}/.vimrc"

ln -sf ${DOTPATH}/.config/fish/config.fish ${HOME}/.config/fish/config.fish
echo "symbolic link: ${HOME}/.config/fish/config.fish -> ${DOTPATH}/.config/fish/config.fish

exit 0
