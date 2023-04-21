#!/bin/bash
if [[ ($1 == "-c") ]]; then
    for arg in "$@";
    do
    if [[ ( "$arg" = "USER" ) ]]; then
    echo "user=$USER"
    elif [[ ( "$arg" = "HOME" ) ]]; then
    echo "home=$HOME"
    elif [[ ( "$arg" = "EDITOR" ) ]]; then
    echo "editor=$EDITOR"
    elif [[ ( "$arg" = "PATH" ) ]]; then
    echo "path=$PATH"
    fi; done
else
    for arg in "$@";
    do
    if [[ ( "$arg" = "USER" ) ]]; then
    echo "$arg=$USER"
    elif [[ ( "$arg" = "HOME" ) ]]; then
    echo "$arg=$HOME"
    elif [[ ( "$arg" = "EDITOR" ) ]]; then
    echo "$arg=$EDITOR"
    elif [[ ( "$arg" = "PATH" ) ]]; then
    echo "$arg=$PATH"
fi; done
fi

