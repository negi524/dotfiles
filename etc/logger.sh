# ログを出力する(オプション無しの場合はinfo)
# -l: ログレベルを引数で指定する(info, warn, error)
# $1: ログのメッセージ
function log () {
  local level="info"

  while getopts "l:" option
  do
    case $option in
      l)
        level="$OPTARG"
        ;;
      \?)
        echo "Usage: logger.sh [-l loglevel] message" 1>&2
        exit 1
        ;;
    esac
  done

  # オプション指定を位置パラメータから削除する
  shift `expr $OPTIND - 1`

  local msg=$1

  # メッセージは空白文字が入っている可能性があるため、一つの文字列として渡す
  format_log ${level} "${msg}"
}

# 色をつけて文字を出力する
# FIXME: 標準出力、標準エラー出力に対応
# Usage: format_log warn message
function format_log () {
  local level=$1
  local msg=$2

  case ${level} in
    debug)
      echo -e "\033[32m[DEBUG]\033[0m ${msg}"
      ;;
    warn)
      echo -e "\033[33m[WARN]\033[0m  ${msg}"
      ;;
    error)
      echo -e "\033[31m[ERROR]\033[0m ${msg}"
      ;;
    *)
      echo -e "[INFO]  ${msg}"
      ;;
  esac
}
