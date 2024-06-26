# Neovimの設定を行う関数
function neovim_setting () {
  log "Neovimの設定反映"

  # neovimの設定ディレクトリが存在しない場合は作成する
  local NVIM_DIRS=(".config/nvim" ".config/nvim/lua" ".config/nvim/lua/plugins")
  for directory in ${NVIM_DIRS[@]}
  do
    set_dir ${directory}
  done

  # シンボリックリンクを作成
  local NVIM_FILES=(".config/nvim/init.lua")
  NVIM_FILES+=(".config/nvim/lua/plugins/*.lua")
  for file in ${NVIM_FILES[@]}
  do
    create_ln ${file}
  done
}
