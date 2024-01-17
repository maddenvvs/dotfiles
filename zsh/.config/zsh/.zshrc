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
  id-as"jetbrains-font-macos" \
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

# Add key bindings provided by fzf.
zi ice has'fzf'
zi snippet https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

# Replace zsh's default completion selection menu with fzf.
zi ice has'fzf'
zi light Aloxaf/fzf-tab

# Install zsh-autosuggestions, zsh-completions, F-Sy-H.
zi light @zsh-users+fast

# Docker CLI completion.
zi ice as"completion"
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# Install Homebrew (brew) completions.
zi pack for brew-completions

# Choose "default" theme for F-Sy-H plugin instead of "z-shell" provided by
# @zsh-users+fast Zi package.
if command -v fast-theme &>/dev/null ; then
  fast-theme default &>/dev/null
fi

# Fix group completion format '%F{yellow}-- %d --%f' in Aloxaf/fzf-tab:
# https://github.com/Aloxaf/fzf-tab/issues/24#issuecomment-1500970064
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'


###############################################################################
# Variables
###############################################################################

# HomeBrew coreutils (ls, dircolors, ...) adjustments.
if [[ -n "${HOMEBREW_PREFIX}" ]]; then
  export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${PATH}"
  export MANPATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnuman:${MANPATH}"
fi

# Add local binaries for my personal use.
export PATH="${HOME}/.local/bin:${PATH}"

# The folder where dotfiles are stored.
DOTFILES="${HOME}/.config/dotfiles"

# Generated with vivid (https://github.com/sharkdp/vivid).
# export LS_COLORS='$(vivid generate snazzy)'
export LS_COLORS='*~=0;38;2;102;102;102:bd=0;38;2;154;237;254;48;2;51;51;51:ca=0:cd=0;38;2;255;106;193;48;2;51;51;51:di=0;38;2;87;199;255:do=0;38;2;0;0;0;48;2;255;106;193:ex=1;38;2;255;92;87:fi=0:ln=0;38;2;255;106;193:mh=0:mi=0;38;2;0;0;0;48;2;255;92;87:no=0:or=0;38;2;0;0;0;48;2;255;92;87:ow=0:pi=0;38;2;0;0;0;48;2;87;199;255:rs=0:sg=0:so=0;38;2;0;0;0;48;2;255;106;193:st=0:su=0:tw=0:*.a=1;38;2;255;92;87:*.c=0;38;2;90;247;142:*.d=0;38;2;90;247;142:*.h=0;38;2;90;247;142:*.m=0;38;2;90;247;142:*.o=0;38;2;102;102;102:*.p=0;38;2;90;247;142:*.r=0;38;2;90;247;142:*.t=0;38;2;90;247;142:*.z=4;38;2;154;237;254:*.7z=4;38;2;154;237;254:*.as=0;38;2;90;247;142:*.bc=0;38;2;102;102;102:*.bz=4;38;2;154;237;254:*.cc=0;38;2;90;247;142:*.cp=0;38;2;90;247;142:*.cr=0;38;2;90;247;142:*.cs=0;38;2;90;247;142:*.di=0;38;2;90;247;142:*.el=0;38;2;90;247;142:*.ex=0;38;2;90;247;142:*.fs=0;38;2;90;247;142:*.go=0;38;2;90;247;142:*.gv=0;38;2;90;247;142:*.gz=4;38;2;154;237;254:*.hh=0;38;2;90;247;142:*.hi=0;38;2;102;102;102:*.hs=0;38;2;90;247;142:*.jl=0;38;2;90;247;142:*.js=0;38;2;90;247;142:*.ko=1;38;2;255;92;87:*.kt=0;38;2;90;247;142:*.la=0;38;2;102;102;102:*.ll=0;38;2;90;247;142:*.lo=0;38;2;102;102;102:*.md=0;38;2;243;249;157:*.ml=0;38;2;90;247;142:*.mn=0;38;2;90;247;142:*.nb=0;38;2;90;247;142:*.pl=0;38;2;90;247;142:*.pm=0;38;2;90;247;142:*.pp=0;38;2;90;247;142:*.ps=0;38;2;255;92;87:*.py=0;38;2;90;247;142:*.rb=0;38;2;90;247;142:*.rm=0;38;2;255;180;223:*.rs=0;38;2;90;247;142:*.sh=0;38;2;90;247;142:*.so=1;38;2;255;92;87:*.td=0;38;2;90;247;142:*.ts=0;38;2;90;247;142:*.ui=0;38;2;243;249;157:*.vb=0;38;2;90;247;142:*.wv=0;38;2;255;180;223:*.xz=4;38;2;154;237;254:*.aif=0;38;2;255;180;223:*.ape=0;38;2;255;180;223:*.apk=4;38;2;154;237;254:*.arj=4;38;2;154;237;254:*.asa=0;38;2;90;247;142:*.aux=0;38;2;102;102;102:*.avi=0;38;2;255;180;223:*.awk=0;38;2;90;247;142:*.bag=4;38;2;154;237;254:*.bak=0;38;2;102;102;102:*.bat=1;38;2;255;92;87:*.bbl=0;38;2;102;102;102:*.bcf=0;38;2;102;102;102:*.bib=0;38;2;243;249;157:*.bin=4;38;2;154;237;254:*.blg=0;38;2;102;102;102:*.bmp=0;38;2;255;180;223:*.bsh=0;38;2;90;247;142:*.bst=0;38;2;243;249;157:*.bz2=4;38;2;154;237;254:*.c++=0;38;2;90;247;142:*.cfg=0;38;2;243;249;157:*.cgi=0;38;2;90;247;142:*.clj=0;38;2;90;247;142:*.com=1;38;2;255;92;87:*.cpp=0;38;2;90;247;142:*.css=0;38;2;90;247;142:*.csv=0;38;2;243;249;157:*.csx=0;38;2;90;247;142:*.cxx=0;38;2;90;247;142:*.deb=4;38;2;154;237;254:*.def=0;38;2;90;247;142:*.dll=1;38;2;255;92;87:*.dmg=4;38;2;154;237;254:*.doc=0;38;2;255;92;87:*.dot=0;38;2;90;247;142:*.dox=0;38;2;165;255;195:*.dpr=0;38;2;90;247;142:*.elc=0;38;2;90;247;142:*.elm=0;38;2;90;247;142:*.epp=0;38;2;90;247;142:*.eps=0;38;2;255;180;223:*.erl=0;38;2;90;247;142:*.exe=1;38;2;255;92;87:*.exs=0;38;2;90;247;142:*.fls=0;38;2;102;102;102:*.flv=0;38;2;255;180;223:*.fnt=0;38;2;255;180;223:*.fon=0;38;2;255;180;223:*.fsi=0;38;2;90;247;142:*.fsx=0;38;2;90;247;142:*.gif=0;38;2;255;180;223:*.git=0;38;2;102;102;102:*.gvy=0;38;2;90;247;142:*.h++=0;38;2;90;247;142:*.hpp=0;38;2;90;247;142:*.htc=0;38;2;90;247;142:*.htm=0;38;2;243;249;157:*.hxx=0;38;2;90;247;142:*.ico=0;38;2;255;180;223:*.ics=0;38;2;255;92;87:*.idx=0;38;2;102;102;102:*.ilg=0;38;2;102;102;102:*.img=4;38;2;154;237;254:*.inc=0;38;2;90;247;142:*.ind=0;38;2;102;102;102:*.ini=0;38;2;243;249;157:*.inl=0;38;2;90;247;142:*.ipp=0;38;2;90;247;142:*.iso=4;38;2;154;237;254:*.jar=4;38;2;154;237;254:*.jpg=0;38;2;255;180;223:*.kex=0;38;2;255;92;87:*.kts=0;38;2;90;247;142:*.log=0;38;2;102;102;102:*.ltx=0;38;2;90;247;142:*.lua=0;38;2;90;247;142:*.m3u=0;38;2;255;180;223:*.m4a=0;38;2;255;180;223:*.m4v=0;38;2;255;180;223:*.mid=0;38;2;255;180;223:*.mir=0;38;2;90;247;142:*.mkv=0;38;2;255;180;223:*.mli=0;38;2;90;247;142:*.mov=0;38;2;255;180;223:*.mp3=0;38;2;255;180;223:*.mp4=0;38;2;255;180;223:*.mpg=0;38;2;255;180;223:*.nix=0;38;2;243;249;157:*.odp=0;38;2;255;92;87:*.ods=0;38;2;255;92;87:*.odt=0;38;2;255;92;87:*.ogg=0;38;2;255;180;223:*.org=0;38;2;243;249;157:*.otf=0;38;2;255;180;223:*.out=0;38;2;102;102;102:*.pas=0;38;2;90;247;142:*.pbm=0;38;2;255;180;223:*.pdf=0;38;2;255;92;87:*.pgm=0;38;2;255;180;223:*.php=0;38;2;90;247;142:*.pid=0;38;2;102;102;102:*.pkg=4;38;2;154;237;254:*.png=0;38;2;255;180;223:*.pod=0;38;2;90;247;142:*.ppm=0;38;2;255;180;223:*.pps=0;38;2;255;92;87:*.ppt=0;38;2;255;92;87:*.pro=0;38;2;165;255;195:*.ps1=0;38;2;90;247;142:*.psd=0;38;2;255;180;223:*.pyc=0;38;2;102;102;102:*.pyd=0;38;2;102;102;102:*.pyo=0;38;2;102;102;102:*.rar=4;38;2;154;237;254:*.rpm=4;38;2;154;237;254:*.rst=0;38;2;243;249;157:*.rtf=0;38;2;255;92;87:*.sbt=0;38;2;90;247;142:*.sql=0;38;2;90;247;142:*.sty=0;38;2;102;102;102:*.svg=0;38;2;255;180;223:*.swf=0;38;2;255;180;223:*.swp=0;38;2;102;102;102:*.sxi=0;38;2;255;92;87:*.sxw=0;38;2;255;92;87:*.tar=4;38;2;154;237;254:*.tbz=4;38;2;154;237;254:*.tcl=0;38;2;90;247;142:*.tex=0;38;2;90;247;142:*.tgz=4;38;2;154;237;254:*.tif=0;38;2;255;180;223:*.tml=0;38;2;243;249;157:*.tmp=0;38;2;102;102;102:*.toc=0;38;2;102;102;102:*.tsx=0;38;2;90;247;142:*.ttf=0;38;2;255;180;223:*.txt=0;38;2;243;249;157:*.vcd=4;38;2;154;237;254:*.vim=0;38;2;90;247;142:*.vob=0;38;2;255;180;223:*.wav=0;38;2;255;180;223:*.wma=0;38;2;255;180;223:*.wmv=0;38;2;255;180;223:*.xcf=0;38;2;255;180;223:*.xlr=0;38;2;255;92;87:*.xls=0;38;2;255;92;87:*.xml=0;38;2;243;249;157:*.xmp=0;38;2;243;249;157:*.yml=0;38;2;243;249;157:*.zip=4;38;2;154;237;254:*.zsh=0;38;2;90;247;142:*.zst=4;38;2;154;237;254:*TODO=1:*hgrc=0;38;2;165;255;195:*.bash=0;38;2;90;247;142:*.conf=0;38;2;243;249;157:*.dart=0;38;2;90;247;142:*.diff=0;38;2;90;247;142:*.docx=0;38;2;255;92;87:*.epub=0;38;2;255;92;87:*.fish=0;38;2;90;247;142:*.flac=0;38;2;255;180;223:*.h264=0;38;2;255;180;223:*.hgrc=0;38;2;165;255;195:*.html=0;38;2;243;249;157:*.java=0;38;2;90;247;142:*.jpeg=0;38;2;255;180;223:*.json=0;38;2;243;249;157:*.less=0;38;2;90;247;142:*.lisp=0;38;2;90;247;142:*.lock=0;38;2;102;102;102:*.make=0;38;2;165;255;195:*.mpeg=0;38;2;255;180;223:*.opus=0;38;2;255;180;223:*.orig=0;38;2;102;102;102:*.pptx=0;38;2;255;92;87:*.psd1=0;38;2;90;247;142:*.psm1=0;38;2;90;247;142:*.purs=0;38;2;90;247;142:*.rlib=0;38;2;102;102;102:*.sass=0;38;2;90;247;142:*.scss=0;38;2;90;247;142:*.tbz2=4;38;2;154;237;254:*.tiff=0;38;2;255;180;223:*.toml=0;38;2;243;249;157:*.webm=0;38;2;255;180;223:*.webp=0;38;2;255;180;223:*.woff=0;38;2;255;180;223:*.xbps=4;38;2;154;237;254:*.xlsx=0;38;2;255;92;87:*.yaml=0;38;2;243;249;157:*.cabal=0;38;2;90;247;142:*.cache=0;38;2;102;102;102:*.class=0;38;2;102;102;102:*.cmake=0;38;2;165;255;195:*.dyn_o=0;38;2;102;102;102:*.ipynb=0;38;2;90;247;142:*.mdown=0;38;2;243;249;157:*.patch=0;38;2;90;247;142:*.scala=0;38;2;90;247;142:*.shtml=0;38;2;243;249;157:*.swift=0;38;2;90;247;142:*.toast=4;38;2;154;237;254:*.xhtml=0;38;2;243;249;157:*README=0;38;2;40;42;54;48;2;243;249;157:*passwd=0;38;2;243;249;157:*shadow=0;38;2;243;249;157:*.config=0;38;2;243;249;157:*.dyn_hi=0;38;2;102;102;102:*.flake8=0;38;2;165;255;195:*.gradle=0;38;2;90;247;142:*.groovy=0;38;2;90;247;142:*.ignore=0;38;2;165;255;195:*.matlab=0;38;2;90;247;142:*COPYING=0;38;2;153;153;153:*INSTALL=0;38;2;40;42;54;48;2;243;249;157:*LICENSE=0;38;2;153;153;153:*TODO.md=1:*.desktop=0;38;2;243;249;157:*.gemspec=0;38;2;165;255;195:*Doxyfile=0;38;2;165;255;195:*Makefile=0;38;2;165;255;195:*TODO.txt=1:*setup.py=0;38;2;165;255;195:*.DS_Store=0;38;2;102;102;102:*.cmake.in=0;38;2;165;255;195:*.fdignore=0;38;2;165;255;195:*.kdevelop=0;38;2;165;255;195:*.markdown=0;38;2;243;249;157:*.rgignore=0;38;2;165;255;195:*COPYRIGHT=0;38;2;153;153;153:*README.md=0;38;2;40;42;54;48;2;243;249;157:*configure=0;38;2;165;255;195:*.gitconfig=0;38;2;165;255;195:*.gitignore=0;38;2;165;255;195:*.localized=0;38;2;102;102;102:*.scons_opt=0;38;2;102;102;102:*CODEOWNERS=0;38;2;165;255;195:*Dockerfile=0;38;2;243;249;157:*INSTALL.md=0;38;2;40;42;54;48;2;243;249;157:*README.txt=0;38;2;40;42;54;48;2;243;249;157:*SConscript=0;38;2;165;255;195:*SConstruct=0;38;2;165;255;195:*.gitmodules=0;38;2;165;255;195:*.synctex.gz=0;38;2;102;102;102:*.travis.yml=0;38;2;90;247;142:*INSTALL.txt=0;38;2;40;42;54;48;2;243;249;157:*LICENSE-MIT=0;38;2;153;153;153:*MANIFEST.in=0;38;2;165;255;195:*Makefile.am=0;38;2;165;255;195:*Makefile.in=0;38;2;102;102;102:*.applescript=0;38;2;90;247;142:*.fdb_latexmk=0;38;2;102;102;102:*CONTRIBUTORS=0;38;2;40;42;54;48;2;243;249;157:*appveyor.yml=0;38;2;90;247;142:*configure.ac=0;38;2;165;255;195:*.clang-format=0;38;2;165;255;195:*.gitattributes=0;38;2;165;255;195:*.gitlab-ci.yml=0;38;2;90;247;142:*CMakeCache.txt=0;38;2;102;102;102:*CMakeLists.txt=0;38;2;165;255;195:*LICENSE-APACHE=0;38;2;153;153;153:*CONTRIBUTORS.md=0;38;2;40;42;54;48;2;243;249;157:*.sconsign.dblite=0;38;2;102;102;102:*CONTRIBUTORS.txt=0;38;2;40;42;54;48;2;243;249;157:*requirements.txt=0;38;2;165;255;195:*package-lock.json=0;38;2;102;102;102:*.CFUserTextEncoding=0;38;2;102;102;102'


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

# Setup bindings for both smkx and rmkx key variants.
# https://github.com/kovidgoyal/kitty/discussions/5248#discussioncomment-3071398
# Home
bindkey '\e[H'  beginning-of-line
bindkey '\eOH'  beginning-of-line
# End
bindkey '\e[F'  end-of-line
bindkey '\eOF'  end-of-line
# Delete
bindkey '\e[3~' delete-char
# Backspace
bindkey '\e?' backward-delete-char
# PageUp
bindkey '\e[5~' up-line-or-history
# PageDown
bindkey '\e[6~' down-line-or-history


###############################################################################
# Aliases
###############################################################################

# Better ls.
alias l="ls -lAhF --color --group-directories-first"

# Show disk usage of a current directory.
alias duc='du -sh $(ls -A) | sort -h -r'

# Move to dotfiles directory.
alias dtf="cd ${DOTFILES}"

# Alias for Zi plugin update.
alias zu='zi self-update && zi update --parallel --reset --all'

# Alias for Homebrew update.
alias bu='brew update && brew upgrade'

# Alias for update of the setup.
alias au='bu; zu'


###############################################################################
# Notes
###############################################################################

__NOTES_DIR="${HOME}/notes"

function note() {
  # Ensure that notes folder exists.
  mkdir -p "${__NOTES_DIR}"

  local notes_file="all"
  if [[ $# -gt 0 ]]; then
    notes_file="${1}"
  fi

  "${EDITOR}" "${__NOTES_DIR}/${notes_file}"
}

# note() function autocompletion.
function _note_autocompletion() {
  _files -W "${__NOTES_DIR}"
}
compdef _note_autocompletion note


###############################################################################
# fzf (https://github.com/junegunn/fzf)
###############################################################################

# Specify default command used on every fzf invocation when there is no initial
# list available (when fzf tries to read the list from stdin instead of a pipe).
# Inspired from here:
# https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
export FZF_DEFAULT_COMMAND="command find -L . -mindepth 1 \
  -path '*/.git/*' -prune -o \
  -type f -print -o \
  -type d -print -o \
  -type l -print 2>/dev/null | cut -b3-"

# Specify default commands for Ctrl-T and Alt-C commands.
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \
  -path '*/.git/*' -prune -o \
  -type d -print 2>/dev/null | cut -b3-"

# Alt-C combination doesn't work on MacOS, producing 'ç' character. Remap the
# character to a desired behaviour. Taken from here:
# https://github.com/junegunn/fzf/issues/164#issuecomment-581837757
if [[ $OSTYPE == "darwin"* ]]; then
  bindkey -M emacs 'ç' fzf-cd-widget
fi


###############################################################################
# Rust
###############################################################################

readonly _RUST_ENV="${HOME}/.cargo/env"
[[ -f "${_RUST_ENV}" ]] && source "${_RUST_ENV}"


###############################################################################
# VSCodium
###############################################################################

# Make an alias like VSCode does.
if [[ -x "$(command -v codium)" ]]; then
  alias code='codium'
fi


###############################################################################
# Misc
###############################################################################

# Load machine-specific zsh configuration.
readonly ZSHRC_LOCAL="${ZDOTDIR}/.zshrc.local"
[[ -f "${ZSHRC_LOCAL}" ]] && source "${ZSHRC_LOCAL}"

