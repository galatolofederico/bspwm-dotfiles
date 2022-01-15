#!/bin/sh

ENV_NAME="scholar-stats-env"
ENV_DIR="$HOME/.config/"

if [ ! -d "$ENV_DIR/$ENV_NAME" ]; then
    echo "Missing env"
    cd "$ENV_DIR" || exit
    virtualenv --python=python3 "$ENV_NAME"
    . "$ENV_DIR/$ENV_NAME/bin/activate"
    pip install scholarly
fi

. "$ENV_DIR/$ENV_NAME/bin/activate"
python $HOME/bin/scholar-stats.py