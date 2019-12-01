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
  vim_setting

  # fish -------------------------------------
  if type fish > /dev/null 2>&1; then
    fish_setting
  fi
}

# vimの設定を行う関数
function vim_setting () {

  # vimの設定ディレクトリが存在しない場合は作成する
  local VIM_DIRS=(".vim" ".vim/colors" ".vim/autoload")
  for var in ${VIM_DIRS[@]}
  do
    set_dir ${var}
  done

  # シンボリックリンクを作成
  local VIM_FILES=(".vim/colors/*.vim" ".vim/autoload/plug.vim")
  for var in ${VIM_FILES[@]}
  do
    create_ln ${var}
  done
}

# fishの設定を行う関数
function fish_setting () {

  # fishの設定ディレクトリが存在しない場合は作成する
  local FISH_DIRS=(".config/fish" ".config/fish/functions")
  for var in ${FISH_DIRS[@]}
  do
    set_dir ${var}
  done

  # シンボリックリンクを作成
  local FISH_FILES=(".config/fish/config.fish" ".config/fish/functions/*.fish")
  for var in ${FISH_FILES[@]}
  do
    create_ln ${var}
  done
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
