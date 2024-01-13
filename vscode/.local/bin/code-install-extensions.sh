#!/bin/zsh

readonly VSCODE_INSTALLED_EXTENSIONS="${HOME}/.config/vscode/installed-extensions"

if [[ -x "$(command -v codium)" ]]; then
    xargs -L 1 codium --install-extension < "${VSCODE_INSTALLED_EXTENSIONS}-vscodium"
fi

if [[ -x "$(command -v code)" ]]; then
    xargs -L 1 code --install-extension < "${VSCODE_INSTALLED_EXTENSIONS}-vscode"
fi
