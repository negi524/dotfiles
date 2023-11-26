# 配色の設定
export LSCOLORS=gxfxcxdxbxegedabagacad

# 補完の有効化
autoload -U compinit && compinit

# ショートカット設定
alias ls='ls -GF'
alias ll='ls -lGF'
alias la='ls -laGF'

# zplugによるプラグイン管理
source ~/.zplug/init.zsh

# 履歴からコマンドを補完する
zplug "zsh-users/zsh-autosuggestions"
# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#44375e,bold"

# シンタックスハイライト
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Then, source plugins and add commands to $PATH
zplug load --verbose
