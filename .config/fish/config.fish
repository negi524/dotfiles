# 配色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad

switch (uname)
case Linux
  set OS 'Linux'
  # tmuxの開発環境を構築するコマンド
  function ide
    tmux split-window -v -p 30
  end
case Darwin
  set OS 'Mac OS'
  # pyenv用の設定
  eval (pyenv init --path | source)

  # Javaのデフォルトバージョンを18で指定
  set -x JAVA_HOME (/usr/libexec/java_home -v 18)

  # 独自コマンドのパスを通す
  set -x PATH $PATH ~/dotfiles/bin

# Rancher Desktop用のパスを設定
set --export --prepend PATH "~/.rd/bin"

  # コマンドラインからググるコマンド
  function gg
    open -a /Applications/Google\ Chrome.app \
    "https://www.google.com/search?q=$argv"
    echo "Now googling $argv..."
  end

  # tmuxの開発環境を構築するコマンド
  function ide
    tmux split-window -v -p 30
  end
case '*'
  set OS 'Stranger'
end

# echo "Hello, $OS !"

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '# '
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'


# fzfの古いキーバインディングを利用しない設定
set -U FZF_LEGACY_KEYBINDINGS 0

