
# TODO: ログレベルによって出力する色を定義する
# TODO: オプションを読み込む
# TODO: オプションの引数によって条件分岐

# オプション
# -l: ログレベルを引数で指定する(info, warn, error)
# $2: ログのメッセージ
function log () {
  local MESSAGE=$2
  echo ${LEVEL}
}
