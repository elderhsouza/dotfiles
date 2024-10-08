# term
export TERM=xterm-256color

# language/locale
LANG=C.UTF-8
LC_CTYPE=C.UTF-8
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=

# compilation flags
export ARCHFLAGS="-arch x86_64"

# speeds up git repostiories
DISABLE_UNTRACKED_FILES_DIRTY=true

# enable zsh-options
setopt autocd extendedglob nomatch

# disable zsh-options
unsetopt beep notify

# Keybindings
#bindkey -e
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
#bindkey '^p' history-search-backward
#bindkey '^n' history-search-forward
#bindkey '^[w' kill-region

# load completions
autoload -Uz compinit && compinit
# zstyle :compinstall filename "$HOME/.zshrc"

# devbox
DEVBOX_NO_PROMPT=true
eval "$(devbox global shellenv --init-hook)"

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# #download zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

## source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab

## add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# load completions
zinit cdreplay -q

# history
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HIST_STAMPS=yyyy-mm-dd
HIST_DUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completion styling
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# aliases
alias myip="curl http://ipecho.net/plain; echo"
alias distro="cat /etc/*-release"
alias kernel="uname -r"
alias reload="exec $SHELL"
alias update="sudo nala update && nala list --upgradeable"
alias upgrade="sudo nala upgrade"
alias ps="ps aux"
alias grep="rg"

# neovim
alias vim="nvim"
export EDITOR=nvim


# eza
alias li="eza --color=always --long --git --icons=always --group-directories-first --no-filesize --no-time --no-user --no-permissions"
alias ll="eza --color=always --long --git --icons=always --group-directories-first --octal-permissions"
alias la="eza --color=always --long --git --icons=always --group-directories-first --octal-permissions --all"

# fzf
## configure fzf to use fd instead of find
FZF_SHOW_FILE_OR_DIR_PREVIEW="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$FZF_SHOW_FILE_OR_DIR_PREVIEW'"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git --color=always"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
  export | unset) fzf --preview "eval 'echo $'{}" "$@" ;;
  ssh) fzf --preview 'dig {}' "$@" ;;
  *) fzf --preview "$FZF_SHOW_FILE_OR_DIR_PREVIEW" "$@" ;;
  esac
}

## fzf theme
export FZF_DEFAULT_OPTS=" \
  --color=spinner:#f4dbd6,hl:#ed8796 \
  --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
  --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
  --color=selected-bg:#494d64 \
  --multi \
  --ansi"

## fzf zsh
eval "$(fzf --zsh)"

## fzf-git
source ~/fzf-git.sh/fzf-git.sh

# bat
export BAT_THEME="Catppuccin Macchiato"
alias cat="bat"

# direnv
eval "$(direnv hook zsh)"

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# Add ~/.local/bin to PATH
export PATH=$HOME/.local/bin:$PATH

# starship prompt
eval "$(starship init zsh)"

# cursor
function cursor {
  echo "cursor function called with args: $@" >>~/cursor_debug.log
  if [ $# -eq 0 ]; then
    return
  fi
  (nohup ~/AppImages/cursor.appimage --no-sandbox "$@" >/dev/null 2>&1 &)
}

# # Start SSH Agent
# if [ -z "$SSH_AUTH_SOCK" ]; then
#   # Check for a currently running instance of the agent
#   RUNNING_AGENT="$(ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]')"
#   if [ "$RUNNING_AGENT" = "0" ]; then
#     # Launch a new instance of the agent
#     ssh-agent -s &>$HOME/.ssh/ssh-agent
#   fi
#   eval $(cat $HOME/.ssh/ssh-agent)
# fi

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nano'
# fi

# zellij

if [ -e /home/ehs/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ehs/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

eval "$(zellij setup --generate-auto-start zsh)"
