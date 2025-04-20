case $(uname) in
  "Darwin" )
    # MacOSの場合

    # Homebrewの設定
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # pyenv用の設定
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # Flutter
    if type flutter > /dev/null 2>&1; then
      export PATH=$HOME/development/flutter/bin:$PATH
    fi

    # Ruby
    if type ruby > /dev/null 2>&1; then
      export RBENV_ROOT="$HOME/.rbenv"
      export PATH="$RBENV_ROOT/bin:$PATH"
      eval "$(rbenv init -)"
    fi

    if type firebase > /dev/null 2>&1; then
      # firebase-tools
      export PATH=$PATH:$HOME/.pub-cache/bin
    fi

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
