# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

# 配色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad

# 補完の有効化
autoload -Uz compinit && compinit

# ショートカット設定
alias ls='ls -GF'
alias ll='ls -lGF'
alias la='ls -laGF'

# miseの有効化
eval "$(mise activate zsh)"
# uvの補完設定
eval "$(uv generate-shell-completion zsh)"

# git-promptの設定
source ~/.git-prompt.sh

# ファイル変更の状態を可視化
GIT_PS1_SHOWDIRTYSTATE=true
# ステージングされていない新規ファイルを可視化
GIT_PS1_SHOWUNTRACKEDFILES=true
# stashの状態を可視化
GIT_PS1_SHOWSTASHSTATE=true
# HEADとの差分を可視化する
GIT_PS1_SHOWUPSTREAM=auto
setopt PROMPT_SUBST ; PS1='%F{#9980A1}[%D %T]%f %F{#90C9C1}%(3~|.../%2~|%~)%f %F{#E9C071}$(__git_ps1 "(%s)")%f%# '

# fzfの設定
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zplugによるプラグイン管理
source ~/.zplug/init.zsh

# 履歴からコマンドを補完する
zplug "zsh-users/zsh-autosuggestions"
# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#44375e,bold"

# シンタックスハイライト
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Then, source plugins and add commands to $PATH
zplug load
