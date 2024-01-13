#!/bin/zsh

VSCODE_INSTALLED_EXTENSIONS="${HOME}/.config/vscode/installed-extensions"

if [[ -x "$(command -v codium)" ]]; then
    codium --list-extensions > "${VSCODE_INSTALLED_EXTENSIONS}-vscodium"
fi

if [[ -x "$(command -v code)" ]]; then
    code --list-extensions > "${VSCODE_INSTALLED_EXTENSIONS}-vscode"
fi
