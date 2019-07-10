alias ll='ls -l'
alias la='ls -la'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ggrep='grep --exclude-dir=.git'
alias ..='cd ..'

# fishシェルが利用可能な場合のみfishを実行する
if type fish > /dev/null 2>&1; then
  # シェルをfishに設定する
  SHELL=`which fish`
  exec `which fish`
else
  echo "exec bash!"
fi
