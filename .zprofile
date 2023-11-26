case $(uname) in
  "Darwin" )
    # MacOSの場合

    # pyenv用の設定
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
  ;;
  * )
    # その他のOSの場合
    # do nothing
  ;;
esac

# TODO: 使っているうちに不便を感じたら修正
# fishから移行メモ-------------------------------------------------------
# Javaのデフォルトバージョンを18で指定
# set -x JAVA_HOME (/usr/libexec/java_home -v 18)

# 独自コマンドのパスを通す
# set -x PATH $PATH ~/dotfiles/bin

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
# set --export --prepend PATH "/Users/negita/.rd/bin"
  # set -x PATH $PATH ~/.rd/bin
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
