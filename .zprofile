case $(uname) in
  "Darwin" )
    # MacOSの場合

    # pyenv用の設定
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # Javaのデフォルトバージョンを18で指定
    export JAVA_HOME=$(/usr/libexec/java_home -v 18)
  ;;
  * )
    # その他のOSの場合
    # do nothing
  ;;
esac

# Rancher Desktop用のパスを設定
export PATH="$PATH:$HOME/.rd/bin"

# Flutter
# Flutterは手動インストール必要 https://docs.flutter.dev/get-started/install/macos/web
export PATH=$HOME/development/flutter/bin:$PATH

# Firebase
export PATH=$PATH:$HOME/.pub-cache/bin

# 独自コマンドのパスを通す
export PATH=$PATH:~/dotfiles/bin

# ctrl+wで一つ前のスラッシュまで削除する
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'
