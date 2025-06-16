# .zshenv is sourced on all invocations of the shell, unless the -f option is set.
# It should contain commands to set the command search path, plus other important environment variables.
# .zshenv' should not contain commands that produce output or assume the shell is attached to a tty.

# The folder to search for shell startup files.
export ZDOTDIR="${HOME}/.config/zsh"

# Source .zshenv from ZDOTDIR folder.
# This enables reuse of zsh configuration among shells with no ZDOTDIR specified
# and shells with ZDOTDIR already pointing to proper location specified above.
readonly ZSHENV="${ZDOTDIR}/.zshenv"
[[ -f "${ZSHENV}" ]] && source "${ZSHENV}"

# Load machine-specific configuration.
readonly ZSHENV_LOCAL="${HOME}/.zshenv.local"
[[ -f "${ZSHENV_LOCAL}" ]] && source "${ZSHENV_LOCAL}"
