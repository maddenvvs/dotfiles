# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


###############################################################################
# Plugins
###############################################################################

# Configure Zi paths to use during its and its' plugins installation.
typeset -A ZI
ZI[HOME_DIR]="${ZDOTDIR}/.zi"
ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"

# Zi-generated installation script.
if [[ ! -f "${ZI[BIN_DIR]}/zi.zsh" ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "${ZI[HOME_DIR]}" && command chmod go-rwX "${ZI[HOME_DIR]}"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "${ZI[BIN_DIR]}" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "${ZI[BIN_DIR]}/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# Add Meta Plugins Zi Annex.
# https://wiki.zshell.dev/ecosystem/annexes/meta-plugins
zi light z-shell/z-a-meta-plugins

# Install auxiliary modules required for Zi itself.
zi light @annexes

# Install JetBrains font.
zi ice if"[[ $OSTYPE = linux* ]]" \
  id-as"jetbrains-font-linux" \
  from"gh-r" \
  bpick"JetBrainsMono.zip" \
  extract \
  nocompile \
  depth"1" \
  atclone="mkdir -p ${HOME}/.local/share/fonts/; rm -f *Windows*; mv -vf *.ttf ${HOME}/.local/share/fonts/; fc-cache -v -f" \
  atpull"%atclone"
zi light ryanoasis/nerd-fonts

zi ice if"[[ -d ${HOME}/Library/Fonts ]] && [[ $OSTYPE = darwin* ]]" \
  id-as"jetbrains-font" \
  from"gh-r" \
  bpick"JetBrainsMono.zip" \
  extract \
  nocompile \
  depth"1" \
  atclone="rm -f *Windows*; mv -vf *.ttf ${HOME}/Library/Fonts/" \
  atpull"%atclone"
zi light ryanoasis/nerd-fonts

# Install Powerlevel10k theme.
zi ice atinit'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' \
       atload"[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh" \
       depth=1 nocd
zi light romkatv/powerlevel10k

# Docker CLI completion.
zi ice as"completion"
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Install fzf with key bindings.
zi pack"bgn-binary+keys" for fzf

# Replace zsh's default completion selection menu with fzf.
zi light Aloxaf/fzf-tab

# Install zsh-autosuggestions, zsh-completions, F-Sy-H.
zi light @zsh-users+fast

# Choose "default" theme for F-Sy-H plugin instead of "z-shell" provided by
# @zsh-users+fast Zi package.
if command -v fast-theme &>/dev/null ; then
  fast-theme default &>/dev/null
fi


###############################################################################
# Variables
###############################################################################

# Add local binaries for my personal use.
export PATH="${HOME}/.local/bin:${PATH}"

# The folder where dotfiles are stored.
DOTFILES="${HOME}/.config/dotfiles"

# Specify default command used on every fzf invocation when there is no initial
# list available (when fzf tries to read the list from stdin instead of a pipe).
export FZF_DEFAULT_COMMAND="find * -path '*/.git/*' -prune -o -print 2>/dev/null"


###############################################################################
# Options
# https://zsh.sourceforge.io/Doc/Release/Options.html
###############################################################################

# Don't beep on error.
setopt NO_BEEP

# Use cd by typing directory name if it's not a command.
setopt AUTO_CD

# Configure history.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# The following parameters were taken from
# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/history.md
# Write the history file in the ':start:elapsed;command' format.
setopt EXTENDED_HISTORY

# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY

# Share history between all sessions.
setopt SHARE_HISTORY

# Expire a duplicate event first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST

# Do not record an event that was just recorded again.
setopt HIST_IGNORE_DUPS

# Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_ALL_DUPS

# Do not display a previously found event.
setopt HIST_FIND_NO_DUPS

# Do not record an event starting with a space.
setopt HIST_IGNORE_SPACE

# Do not write a duplicate event to the history file.
setopt HIST_SAVE_NO_DUPS

# Do not execute immediately upon history expansion.
setopt HIST_VERIFY

# Append to history file.
setopt APPEND_HISTORY

# Don't store history commands.
setopt HIST_NO_STORE


###############################################################################
# Bindkeys
###############################################################################

# Choose Emacs command line editing style.
bindkey -e

# [Ctrl+RightArrow or Cmd+RightArrow] - move forward one word.
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M emacs '^[[1;9C' forward-word

# [Ctrl+LeftArrow or Cmd+LeftArrow] - move backward one word.
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M emacs '^[[1;9D' backward-word


###############################################################################
# Aliases
###############################################################################

# Detect which `ls` flavor is in use.
if ls --color &>/dev/null; then # GNU `ls`
    colorflag="--color"
else # macOS `ls`
    colorflag="-G"
fi
alias l="ls -lAhF ${colorflag}"

# Show disk usage of a current directory.
alias duc='du -sh $(ls -A) | sort -h -r'

# Move to dotfiles directory.
alias dtf="cd ${DOTFILES}"

# Alias for Zi plugin update.
alias zu='zi self-update && zi update --parallel --reset --all'


# Todos management.
TODOS_DIR="${HOME}/todos"

function todo() {
  # Ensure that todos folder exists.
  mkdir -p "${TODOS_DIR}"

  local todo_file="todo-list"
  if [[ $# -gt 0 ]]; then
    todo_file="${1}"
  fi

  "${EDITOR}" "${TODOS_DIR}/${todo_file}"
}

# List all todo files.
alias lstd="l -1 ${TODOS_DIR}"


###############################################################################
# Misc
###############################################################################

# Load machine-specific zsh configuration.
readonly ZSHRC_LOCAL="${ZDOTDIR}/.zshrc.local"
[[ -f "${ZSHRC_LOCAL}" ]] && source "${ZSHRC_LOCAL}"

