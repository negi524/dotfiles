case "$(uname)" in
  'Darwin')
    # コマンドラインからググるコマンド
    function gg () {
      local WORD=$@
      open -a /Applications/Google\ Chrome.app \
        "https://www.google.com/search?q=${WORD}"
      echo "Now googling ${WORD}..."
    }
    ### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
    export PATH="~/.rd/bin:$PATH"
    ### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
    ;;
  'Linux')
    ;;
  *)
    ;;
esac

