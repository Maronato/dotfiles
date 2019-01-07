# Useful osx aliases

# Useful osx functions
mkdir () {
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}
alias mkdir="mkdir -p -- '$1' && cd -P -- '$1'"
