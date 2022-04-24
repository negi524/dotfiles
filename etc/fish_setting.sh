# fishの設定を行う関数
function fish_setting () {

  # fishの設定ディレクトリが存在しない場合は作成する
  local FISH_DIRS=(".config/fish" ".config/fish/functions")
  for var in ${FISH_DIRS[@]}
  do
    set_dir ${var}
  done

  # シンボリックリンクを作成
  local FISH_FILES=(".config/fish/config.fish" ".config/fish/conf.d/fnm.fish")
  FISH_FILES+=(".config/fish/functions/*.fish")
  for var in ${FISH_FILES[@]}
  do
    create_ln ${var}
  done
}

