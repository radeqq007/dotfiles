ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load starship prompt
eval "$(starship init zsh)"

# Plugins
zinit lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab

zinit wait lucid light-mode for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-history-substring-search \
  hlissner/zsh-autopair

# History
HISTSIZE=3000
HISTFILE=~/.zsh-history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Binds
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

bindkey '^p' history-substring-search-up
bindkey '^n' history-substring-search-down

# Completion stylig
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'

# Aliases
alias ls='ls --color=auto'
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# hyprshot
export HYPRSHOT_DIR=$HOME/Pictures/Screenshots

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Go Lang
export GOPATH="$HOME/go"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"

# zoxide
eval "$(zoxide init zsh)"

typeset -U path

path=(
  $HOME/.local/bin
  $GOPATH/bin
  /usr/local/go/bin
  $HOME/.cargo/bin
  $HOME/.local/share/pnpm/bin
  $PNPM_HOME
  $BUN_INSTALL/bin
  $HOME/.spicetify
  $HOME/.opencode/bin
  $path
)

