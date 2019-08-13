# 配色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad

switch (uname)
case Linux
  set OS 'Linux'
case Darwin
  set OS 'Mac OS'
  # pyenv用の設定
  eval (pyenv init - | source)

  # コマンドラインからググるコマンド
  function gg
    open -a /Applications/Google\ Chrome.app \
    "https://www.google.com/search?q=$argv"
    echo "Now googling $argv..."
  end
case '*'
  set OS 'Stranger'
end

echo "Hello, $OS !"

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
