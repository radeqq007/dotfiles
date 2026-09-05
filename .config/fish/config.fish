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

fish_add_path $HOME/.local/bin
fish_add_path (go env GOPATH)/bin
fish_add_path /usr/local/go/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/share/pnpm/bin
fish_add_path $PNPM_HOME
fish_add_path $BUN_INSTALL/bin
fish_add_path $HOME/.spicetify
fish_add_path $HOME/.opencode/bin
fish_add_path $HOME/.config/scripts

zoxide init fish | source
