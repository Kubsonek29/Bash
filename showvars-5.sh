#!/bin/bash

if [[ ($1 == "-n") ]]; then
    printenv | wc -l
else
    for arg in "$@";
    do
    if [[ ( "$(printenv $arg)" != "" ) ]]; then
    echo "$arg="$(printenv $arg);
    fi
done
fi