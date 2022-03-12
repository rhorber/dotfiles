export LS_OPTIONS='--color=auto -h'
alias grep='grep --color=auto'

eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -la'
alias dir='ls $LS_OPTIONS'
