case $(uname) in
  "Darwin" )
    # MacOSの場合

    # Homebrewの設定
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Flutter
    # if type flutter > /dev/null 2>&1; then
    #   export PATH=$HOME/development/flutter/bin:$PATH
    # fi

    if type firebase > /dev/null 2>&1; then
      # firebase-tools
      export PATH=$PATH:$HOME/.pub-cache/bin
    fi

    # PostgreSQLのパスを通す
    export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

  ;;
  * )
    # その他のOSの場合
    # do nothing
  ;;
esac

# Rancher Desktop用のパスを設定
export PATH="$PATH:$HOME/.rd/bin"

# 独自コマンドのパスを通す
export PATH=$PATH:~/dotfiles/bin

# ctrl+wで一つ前のスラッシュまで削除する
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'
