# speeds up git repostiories
DISABLE_UNTRACKED_FILES_DIRTY="true"

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# enable zsh-options
setopt autocd extendedglob nomatch

# disable zsh-options
unsetopt beep notify

# keyword bindings emacs style
bindkey -e

# enable 'modern auto completion'
zstyle :compinstall filename '/home/dev/.zshrc'
autoload -Uz compinit
compinit

# zgenom
source "${HOME}/.zgenom/zgenom.zsh"

zgenom autoupdate

if ! zgenom saved; then
  zgenom ohmyzsh

  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/sudo
  zgenom ohmyzsh plugins/wd

  [[ "$(uname -s)" = Darwin ]] && zgenom ohmyzsh plugins/macos

  zgenom load zsh-users/zsh-syntax-highlighting
  zgenom load zsh-users/zsh-completions

  zgenom save

  zgenom compile "$HOME/.zshrc"
  # zgenom compile $ZDOTDIR
fi

# eval "$(starship init zsh)"

# asdf
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# plugins=(wd git docker npm zsh-nvm zsh-autosuggestions zsh-syntax-highlighting)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nano'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Aliases
# alias myip="curl http://ipecho.net/plain; echo"
# alias distro="cat /etc/*-release"
# alias kernel="uname -r"
# alias reload="zgenom reset && exec $SHELL"
# alias update="sudo nala update && nala list --upgradeable"
# alias upgrade="sudo nala upgrade"
# alias zshcfg="nano ~/.zshrc"
# alias cat="bat"
# alias ll="exa -l --group-directories-first --octal-permissions"
# alias la="exa -la --group-directories-first --octal-permissions"
# alias grep="rg"
# alias tf="terraform"

# FZF
# source /usr/share/doc/fzf/examples/key-bindings.zsh
# source /usr/share/doc/fzf/examples/completion.zsh

# export FZF_DEFAULT_COMMAND="fd --type file --type directory --follow --hidden --exclude .git --color=always"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_DEFAULT_OPTS="--ansi"

# Cargo
# export PATH=$HOME/.cargo/bin:$PATH

# Go
# export PATH=/usr/local/go/bin:$PATH

# Add ~/.local/bin to PATH
# export PATH=$HOME/.local/bin:$PATH

# BAT Theme
# export BAT_THEME=GitHub

# Start SSH Agent
# if [ -z "$SSH_AUTH_SOCK" ]; then
#    # Check for a currently running instance of the agent
#    RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
#    if [ "$RUNNING_AGENT" = "0" ]; then
#         # Launch a new instance of the agent
#         ssh-agent -s &> $HOME/.ssh/ssh-agent
#    fi
#    eval `cat $HOME/.ssh/ssh-agent`
# fi

# Terraform
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/terraform terraform

# Android SDK
# export PATH=/usr/local/android-studio/bin:$HOME/Android/Sdk/platform-tools:$PATH
# export ANDROID_HOME=$HOME/Android/Sdk

