#!/bin/bash
set -eu

DOTPATH="${HOME}/dotfiles"

cd ${DOTPATH}

# main関数
function main () {

  local DOTLIST=(".vimrc" ".bash_profile")

  for var in ${DOTLIST[@]}
  do
    create_ln ${var}
  done

  # vim --------------------------------------
  set_vim

  # fish -------------------------------------
  set_fish
}

# vimの設定を行う関数
function set_vim () {

  # vimの設定ディレクトリが存在しない場合は作成する
  local VIM_DIRS=(".vim" ".vim/colors" ".vim/autoload")
  for var in ${VIM_DIRS[@]}
  do
    set_dir ${var}
  done

  # シンボリックリンクを作成
  local VIM_FILES=(".vim/colors/hybrid.vim" ".vim/autoload/plug.vim")
  for var in ${VIM_FILES[@]}
  do
    create_ln ${var}
  done
}

# fishの設定を行う関数
function set_fish () {

  # fishの設定ディレクトリが存在しない場合は作成する
  set_dir ".config/fish"
  set_dir ".config/fish/functions"

  create_ln ".config/fish/config.fish"
  create_ln ".config/fish/functions/fish_prompt.fish"
}

# シンボリックリンクを貼る関数
# 同じファイルが存在する場合、上書きする
# $1: 対象ファイル
function create_ln () {
  local FILE=$1

  ln -vsf ${DOTPATH}/${FILE} ${HOME}/${FILE}
  return 0
}

# 対象のディレクトリがない場合は作成する関数
# $1: 対象ディレクトリ
function set_dir () {
  local DIR=$1

  if [ ! -d ${HOME}/${DIR} ]; then
    mkdir ${HOME}/${DIR}
  fi
  return 0
}

# main関数実行
main


exit 0
