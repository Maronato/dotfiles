#!/bin/bash

# Get current working dir and sub / for _
curr_dir=${PWD//\//_}

# Set envs dir
venv_dir=~/pyenvs

# Build path
v_path=$venv_dir/$curr_dir

# Print venvs
if [[ "$(ls -A $v_path 2>/dev/null)" ]]; then
    cd $v_path
    du -hs * | while read line; do
        name=$(echo $line | cut -f2 -d\ )
        size=$(echo $line | cut -f1 -d\ )
        source $name/bin/activate
        count=$(pip freeze | wc -w)
        deactivate
        printf "$name ($size)\t$count packages installed\n"
    done
else
    echo "No envs here"
fi
