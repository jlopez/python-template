#!/bin/bash
# Fail on any error
set -e

# Fix rebase issues inside devcontainer
sudo git config set --global core.checkStat minimal

# Permissions for mounts
sudo chown vscode:vscode ~/.cache ~/.config

# Ensure the lock file is up to date, otherwise the install step may fail later
poetry lock --no-update

# Force the virtual environment to the path set in the .devcontainer.json file
python -mvenv $VIRTUAL_ENV
PATH="$VIRTUAL_ENV/bin:$PATH"
poetry install

# Activate pre commit hooks
pre-commit install

# Configuration files
cat >> ~/.inputrc <<EOF
set completion-ignore-case on
set editing-mode vi
EOF
