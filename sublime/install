#!/bin/sh


info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

function check_overwrite() {
    read -p "
    Sublime settings already present.
    Overwrite .sublime-settings files? [y/n]
    " action
    case "$action" in
    y | Yes | yes ) echo "Yes"; exit;; # If y | yes, reboot
    n | N | No | no) echo "No"; exit;; # If n | no, exit
    * ) echo "Invalid answer. Enter \"y/yes\" or \"N/no\"" && return;;
    esac
}

for d in \
    "$HOME/Library/Application Support/Sublime Text 3" \
    "$HOME/.config/sublime-text-3"; do
    test -d "$d" && {
        ST3_LOCAL="$d"
        break
    }
done

# st3 is not installed
test -n "$ST3_LOCAL" || exit 1

# Check if Package Control is installed
PKG_CTRL_FILE="$ST3_LOCAL/Installed Packages/Package Control.sublime-package"
if [[ ! -f "$PKG_CTRL_FILE" ]]; then
    # create needed directories
    mkdir -p "$ST3_LOCAL/Installed Packages"
    mkdir -p "$ST3_LOCAL/Packages/User/"
    # Install package control
    info "installing package control"
    curl -o "$PKG_CTRL_FILE" \
    "https://sublime.wbond.net/Package Control.sublime-package"
fi

# Check if there are settings present
SETTINGS_FILE="$ST3_LOCAL/Installed Packages/Preferences.sublime-package"
if [[ ! -f "$SETTINGS_FILE" ]]; then
    [[ $(check_overwrite) == "Yes" ]] || { fail "skipping sublime configuration"; exit; }
    info "overwriting settings"
    d_name=$ST3_LOCAL/Packages/User
    h_name=$ST3_LOCAL/Packages
    [[ -f "$d_name" ]] && rm -rf "$d_name"
    ln -sf "$DOTFILES/sublime/User" "$h_name"
fi
