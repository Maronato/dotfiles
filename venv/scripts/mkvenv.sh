#!/bin/bash

# Get current working dir and sub ' ' for -
curr_dir=${PWD// /-}

# And sub / for _
curr_dir=${curr_dir//\//_}

# Set python path
py_path=/usr/local/bin/python3

# Set envs dir
venv_dir=~/pyenvs

# Set defaults
pip=false
venv_name=venv

# Accept one argument. If received, set the env name as it
if [[ $1 && $1 != "pip" ]]; then
    venv_name=$1
    if [[ $2 == "pip" ]]; then
        pip=2
    fi
elif [[ $1 == "pip" ]]; then
    pip=1
fi

# Build path
v_path=$venv_dir/$curr_dir/$venv_name

# Create venv
[[ -d $v_path ]] && echo "env '$venv_name' already exists" || { $py_path -m venv $v_path; echo "env '$venv_name' created"; }

# Create Sublime project file settings for the Anaconda IDE
cat <<EOF >${PWD}/${PWD##*/}.sublime-project
{
    "build_systems":
    [
        {
            "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)",
            "name": "Anaconda Python Builder",
            "selector": "source.python",
            "shell_cmd": "\"${v_path}/bin/python\" -u \"$file\""
        }
    ],
    "folders":
    [
        {
            "path": "."
        }
    ],
    "settings":
    {
        "python_interpreter": "${v_path}/bin/python"
    }
}

EOF
echo "sublime project file created"

# Install dependencies
if [[ $pip != "false" ]]; then
    eval pip=\$$(($pip + 1))
    [[ $pip ]] && eval pip_value=$pip || pip_value=requirements.txt
    avenv $venv_name > /dev/null
    [[ -f $pip_value ]] && { echo "installing '$pip_value' dependencies..."; pip install -q -r $pip_value; echo "done"; } || echo "file '$pip_value' does not exist"
    dvenv > /dev/null
fi
