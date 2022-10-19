# .zshenv is sourced on all invocations of the shell, unless the -f option is set.
# It should contain commands to set the command search path, plus other important environment variables.
# .zshenv' should not contain commands that produce output or assume the shell is attached to a tty.

# The folder to search for shell startup files.
export ZDOTDIR="${ZDOTDIR:-${HOME}/.config/zsh}"

# Preferred editor for local and remote sessions.
export EDITOR='vim'
export VISUAL='vim'

readonly ZSHENV_LOCAL="${HOME}/.zshenv.local"
[[ -f "${ZSHENV_LOCAL}" ]] && source "${ZSHENV_LOCAL}"

