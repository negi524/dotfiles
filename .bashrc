case "$(uname)" in
  'Darwin')
    # コマンドラインからググるコマンド
    function gg () {
      local WORD=$@
      open -a /Applications/Google\ Chrome.app \
        "https://www.google.com/search?q=${WORD}"
      echo "Now googling ${WORD}..."
    }
    ;;
  'Linux')
    ;;
  *)
    ;;
esac

