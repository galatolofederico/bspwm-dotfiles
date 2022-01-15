# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# load aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
# load functions
[ -f ~/.bash_functions ] && source ~/.bash_functions
# load private aliases
[ -f ~/.private_aliases ] && source ~/.private_aliases
# load completions
[ -f ~/.bash_completions ] && source ~/.bash_completions
# load custom stuff
[ -f ~/.bash_custom ] && source ~/.bash_custom

# env variables
export EDITOR=vim
export TERMINAL=alacritty
export PATH=$PATH:$HOME/bin:$HOME/.local/bin

# autocd
shopt -s autocd

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ssh-agent
eval $(ssh-agent) > /dev/null

