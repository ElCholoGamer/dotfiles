export PATH="/usr/local/bin:$HOME/bin:$HOME/.local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"


# ================================
# Global settings
# ================================

export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export PRETTIERD_DEFAULT_CONFIG="$XDG_CONFIG_HOME/prettierd.json"


# ================================
# Program environments
# ================================

# # fnm
eval "$(fnm env --use-on-cd)" > /dev/null

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh --no-rehash)"
eval "$(pyenv virtualenv-init - zsh --no-rehash)"

# TeX Live
export PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux"
export MANPATH="$MANPATH:/usr/local/texlive/2024/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:/usr/local/texlive/2024/texmf-dist/doc/info"

# bat
export BAT_THEME="kanagawa"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"


# ================================
# Aliases
# ================================

# Display server
alias h="Hyprland"

# Python virtualenv aliases
alias ve="python3 -m venv ./.venv"
alias va="source ./.venv/bin/activate"

# ls -> exa
alias ls="exa --color=auto"
alias la="ls -A"
alias ll="ls -lhF --sort=type --icons"
alias lla="ll -A --sort=type --icons"
alias l="ls -F"
alias lt="ls -T --icons"
alias lta="lt -A"

# Peaclock with config
alias peaclock="peaclock --config-dir $XDG_CONFIG_HOME/peaclock"

# Fuzzy cd
alias sd="cd ~ && cd \$(fzf --walker=dir,hidden)"

# rmtrash aliases
alias rmr="/bin/rm"
alias rmdirr="/bin/rmdir"
alias rm="rmtrash"
alias rmdir="rmdirtrash"
alias sudo="sudo " # necessary for some reason


# ================================
# Zsh directory stack
# ================================

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index


# ================================
# Zsh plugins
# ================================

source "$ZDOTDIR/themes/aphrodite/aphrodite.zsh-theme"

source "$ZDOTDIR/plugins/zsh-autopair/autopair.zsh"
autopair-init

source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^ ' autosuggest-accept

source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "$ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

source "/usr/share/doc/pkgfile/command-not-found.zsh"
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=default
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=default


# ================================
# Zsh completion
# ================================

fpath+="$ZDOTDIR/plugins/zsh-completions/src"

zmodload zsh/complist

autoload -U compinit && compinit
_comp_options+=(globdots)

setopt AUTO_LIST
setopt COMPLETE_IN_WORD

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' completer _extensions _complete
zstyle ':completion:*' menu select

bindkey -M menuselect '^[[Z' reverse-menu-complete

# Better history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ================================
# Zsh Vi mode
# ================================

bindkey -v
export KEYTIMEOUT=1
source "$ZDOTDIR/plugins/cursor_mode"

autoload -U select-word-style
select-word-style bash

# For some reason these aren't defaults
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Better history navigation
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Press v to edit command in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Text objects
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
    bindkey -M $km -- '-' vi-up-line-or-history
    for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
        bindkey -M $km $c select-quoted
    done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $km $c select-bracketed
    done
done

# Surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround
