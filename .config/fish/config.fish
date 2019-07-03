# 配色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad

# macではnodebrewを利用しているため、パスを通す
switch (uname)
    case Linux
      echo Hello, Linux!
    case Darwin
      echo Hello, mac OS!
      set -x PATH $HOME/.nodebrew/current/bin $PATH
      # pyenv用の設定
      set -x PYENV_ROOT $HOME/.pyenv
      set -x PATH $PYENV_ROOT/bin $PATH
      eval (pyenv init - | source)
    case '*'
      echo Hello, stranger!
end

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'
