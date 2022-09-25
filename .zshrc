# TODO: automate scheduled "zi update" and "zi self-update".

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
# Load fzf Tab fuzzy completion as a snippet instead of completion.
# fzf fuzzy completion - https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
# Bug in Zi fzf package - https://github.com/z-shell/fzf/blob/main/package.json#L112
zi snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh

# Install F-Sy-H, zsh-autosuggestions, zsh-completions.
# Probably, should be the last module.
zi light @zsh-users+fast

# Include my personal settings for zsh.
zi ice id-as"personal"; zi snippet "${HOME}/.dotfiles/.zshrc.personal"

