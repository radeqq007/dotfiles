source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting

end

alias g="git"
alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gpl="git pull"
alias cls="clear"

set -gx EDITOR nvim

fish_add_path ~/.local/bin

zoxide init fish | source
