#!/bin/bash

t=10
b=10

while getopts ":t:b:" arg; do
    case ${arg} in
    t) t=${OPTARG};;
    b) b=${OPTARG};;
    esac
done
shift $((OPTIND-1)) #resetuje optind

for arg in "$@";
    do
    if [[ ( $arg == "-t "?? ) ]]; then
        continue
    fi
    if [[ ( $arg == "-b "?? ) ]]; then
        continue
    fi
    if [[ ( $arg == *"/coreutils") ]]; then
        echo "$(basename $arg) is not a text file ... skipping ..."
    else
    #if [[ $(file $arg) == "$arg: ASCII text" || $(file $arg) == "$arg: C source, ASCII text" ]]; then
        echo ""
        echo "plik $(basename $arg): HEAD"
        echo "--------------------------------"
        echo "$(head -n ${t} $arg)"
        echo ""
        echo "plik $(basename $arg): TAIL"
        echo "--------------------------------"
        echo "$(tail -n ${b} $arg)"
    #else
        #echo "$(basename $arg) is not a text file ... skipping ..."
    fi
done
echo "======================================================================="