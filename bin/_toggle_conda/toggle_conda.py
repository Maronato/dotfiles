import os

# home = os.path.expanduser("~")
dotfiles = os.environ["DOTFILES"]

ZSH_PATH = dotfiles + "/conda/path.zsh"

lines = []
with open(ZSH_PATH, 'r') as f:
    for idx, line in enumerate(f):
        if '# export PATH="$HOME/anaconda/bin:$PATH"' in line:
            text = 'export PATH="$HOME/anaconda/bin:$PATH"\n'
            print("Conda Activated")
        elif 'export PATH="$HOME/anaconda/bin:$PATH"' in line:
            text = '# export PATH="$HOME/anaconda/bin:$PATH"\n'
            print("Conda Deactivated")
        else:
            text = line
        lines.append(text)

with open(ZSH_PATH, 'w+') as f:
    for line in lines:
        f.write(line)
