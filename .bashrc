case "$(uname)" in
  'Darwin')
    # コマンドラインからググるコマンド
    function gg () {
      local WORD=$1
      open -a /Applications/Google\ Chrome.app \
        "http://www.google.com/search?q=${WORD}"
      echo "Now googling ${WORD}..."
    }
    ;;
  'Linux')
    ;;
  *)
    ;;
esac

