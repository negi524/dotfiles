case "$(uname)" in
  'Darwin')
    echo "hello mac"
    ;;
  'Linux')
    echo "hello linux"
    ;;
  *)
    echo "hello stranger"
    ;;
esac

# コマンドラインからググる
function gg () {
  local WORD=$1
  open -a /Applications/Google\ Chrome.app \
    "http://www.google.com/search?q=${WORD}"
  echo "Now googling ${WORD}..."
}
