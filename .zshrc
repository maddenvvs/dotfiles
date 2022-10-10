# TODO: automate scheduled "zi update" and "zi self-update".

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


###############################################################################
# Options
# https://zsh.sourceforge.io/Doc/Release/Options.html
###############################################################################

# Don't beep on error.
setopt no_beep

# Use cd by typing directory name if it's not a command.
setopt auto_cd

# Configure history.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000


# Store beginning timestamp and duration of each command.
setopt extended_history

# Do not store a command if it is a duplicate of the previous one.
setopt hist_ignore_dups

# Share command history between shells.
setopt share_history

# Do not execute a command immediately upon history expansion.
setopt hist_verify


###############################################################################
# Bindkeys
###############################################################################

# Choose Emacs command line editing style.
bindkey -e

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word

# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word


###############################################################################
# Aliases
###############################################################################

# Detect which `ls` flavor is in use.
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # macOS `ls`
    colorflag="-G"
fi

# Common ls alias.
alias l="ls -lAhF ${colorflag}"

# Open default editor (vim) fast.
alias v="${EDITOR}"

# Show disk usage of a current directory.
alias duc='du -sh $(ls -A) | sort -h -r'

# Dotfiles management.
alias dot="cd ${HOME}/.dotfiles"
alias zrc="${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc"

# Alias for Zi plugin update.
alias zu='zi update -p'


###############################################################################
# Plugins
###############################################################################

# Zi-generated installation script.
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# Add Meta Plugins Zi Annex.
#https://wiki.zshell.dev/ecosystem/annexes/meta-plugins
zi light z-shell/z-a-meta-plugins

# Install auxiliary modules required for Zi itself.
zi light @annexes

# Install Powerlevel10k theme.
# TODO: Automate font installation.
zi light @romkatv

# Install fzf with key bindings.
zi pack"bgn-binary+keys" for fzf

# Install F-Sy-H, zsh-autosuggestions, zsh-completions.
zi light @zsh-users+fast

# Load fzf Tab fuzzy completion as a snippet instead of completion.
# TODO: for some reason, this module should be loaded last. Figure out why.
# fzf fuzzy completion - https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
# Bug in Zi fzf package - https://github.com/z-shell/fzf/blob/main/package.json#L112
zi snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh


###############################################################################
# Misc
###############################################################################

# Load machine-specific zsh configuration.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

