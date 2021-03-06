#!/bin/bash

# Get current working dir and sub ' ' for -
curr_dir=${PWD// /-}

# And sub / for _
curr_dir=${curr_dir//\//_}

# Set envs dir
venv_dir=~/pyenvs

# Accept one argument. If received, set the env name as it
if [[ $1 ]]; then
    venv_name=$1
else
    venv_name=venv
fi

# Build path
v_path=$venv_dir/$curr_dir/$venv_name

# Deletes the environment
[[ -d $v_path ]] && { rm -r $v_path; echo "env '$venv_name' removed"; } || echo "env '$venv_name' does not exist"

# Deletes sublime project file for Anaconda IDE
rm -f ${PWD##*/}.sublime-project
