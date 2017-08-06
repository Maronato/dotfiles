#!/bin/bash

# Get current working dir and sub / for _
curr_dir=${PWD//\//_}

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

# Activates the environment
[[ -d $v_path ]] && { source $v_path/bin/activate; echo "env '$venv_name' activated"; } || echo "env '$venv_name' does not exist"
