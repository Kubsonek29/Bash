#!/bin/bash

for arg in "$@";
    do
    echo ""
    echo "plik $(basename $arg)"
    echo "--------------------------------"
    echo "$(head $arg)"
    tmp=`wc -l < ${arg}`
    while [[ $tmp -le 10 ]]
    do 
    echo ''
    let tmp=tmp+1
    done
done