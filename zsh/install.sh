#!/bin/sh
#
# ZSH
#
# Updates ZSH and sets it as the default shell

# Check if zsh is updated
if test $(which zsh) != "/usr/local/bin/zsh"
then
  echo "  Updating ZSH."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
    echo "  Setting ZSH as default"
    chsh -s $(which zsh)
  fi

  if [ ! -d "$ZSH" ]
  then
    echo "  Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
fi

exit 0
