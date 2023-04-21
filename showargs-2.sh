#!/bin/bash

tmp=0
#################counter
for arg in "$@";
    do
    if [[ ( $arg == "--" || $arg == "-r" ) ]]; then
            continue
            fi
    let tmp++
done
#########################
echo $tmp
if [[ ( $1 == "-r" ) ]]; then

for arg in "$@";
do
    if [[ ( $arg != "-r" ) ]]; then
        if [[ ( $arg == "--" ) ]]; then
            continue
            fi
            echo "$arg";
    fi
done | tac

else

for arg in "$@";
    do
    if [[ ( $arg == "--" ) ]]; then
            continue
            fi
    echo "$arg";
done
fi
