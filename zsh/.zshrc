# Path to your oh-my-zsh installation.
export ZSH=$HOME"/.oh-my-zsh"

# Use FD for fuzzy
export FZF_DEFAULT_CMD='fd --type file --color=always --strip-cwd-prefix --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_CMD"

export FZF_DEFAULT_OPTS="--ansi"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

#export FZF_TMUX_OPTS='-p80%,60%'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Use tab for auto complete
#bindkey '^I' autosuggest-accept

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
#zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Tmux popup feature
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Configure tmux plugin
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_AUTOQUIT=false

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages # Adds color to man pages
  dirhistory # Quick jump to previous visited directories
  autojump # Quick jump to previous visited directories
  pj # Project jump list
  git # Git
  tmux
  extract # Extracts all types of archives
  zsh-autosuggestions # Zsh command uggestions
  fzf
  fzf-tab
  zsh-syntax-highlighting # Must be last
)

source $ZSH/oh-my-zsh.sh

# User configuration

if [ -d /usr/local/man ]; then
  export MANPATH="/usr/local/man:$MANPATH"
fi

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if command -v nvim > /dev/null; then
  if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
  else
    export EDITOR='nvim'
  fi
else
    export EDITOR='vim'
fi

# Load local configuraiton.
if [ -f "$HOME"/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias python=python3

# Quick access to zsh config.
alias zshrc="$EDITOR ~/.zshrc"

alias hyprc="$EDITOR ~/.config/hypr/hyprland.conf"

if [ -f "$HOME"/.zshrc.local ]; then
  alias zshlrc="$EDITOR ~/.zshrc.local"
fi

alias zsha="$EDITOR ~/.zshrc.aliases"

if [ -f "$HOME"/.zshrc.local.aliases ]; then
  alias zsha="$EDITOR ~/.zshrc.local.aliases"
fi

# Quick access to hypr config.
alias hyprc="$EDITOR ~/.config/hypr/hyprland.conf"

#alias ls='ls -lF --color=auto'
#alias ll='ls -alF --color=auto'
alias ls='eza -la --git'
alias lg='lazygit'

# Perforce aliases
alias po='p4 opened'
alias pld='p4 opened -c default'
alias plc='p4_list_pending_cls'
alias pdc='p4_delete_cl'

function pu {
  if [[ "$1" != "" ]] then
    p4 unshelve -s $1 -c $1
  fi
}

alias mr='mise run'

# Load local aliases.
if [ -f "$HOME"/.zshrc.local.aliases ]; then
  source $HOME/.zshrc.local.aliases
fi

# Mise
eval "$(mise activate zsh)"

# Perforce
if command -v p4 > /dev/null; then
  export P4CONFIG=.p4config
  export P4IGNORE=.p4ignore
  export P4DIFF=p4_diff
  export P4MERGE=p4_merge
fi

[[ -s /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh

# Starship
if command -v starship > /dev/null; then
  eval "$(starship init zsh)"
fi

source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
