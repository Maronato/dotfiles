import os

# home = os.path.expanduser("~")
dotfiles = os.environ["DOTFILES"]

ZSH_PATH = dotfiles + "/conda/path.zsh"

cmd = 'export PATH="$CONDAPATH:$PATH"'

lines = []
with open(ZSH_PATH, 'r') as f:
    for idx, line in enumerate(f):
        if '# {}'.format(cmd) in line:
            text = '{}\n'.format(cmd)
            print("Conda Activated")
        elif '{}'.format(cmd) in line:
            text = '# {}\n'.format(cmd)
            print("Conda Deactivated")
        else:
            text = line
        lines.append(text)

with open(ZSH_PATH, 'w+') as f:
    for line in lines:
        f.write(line)
