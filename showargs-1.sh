#!/bin/bash

if [[ ( $1 == "-r" ) ]]; then
echo $(($#-1))
for (( arg=$#;arg>1;arg-- ));do
        echo "${!arg}"
done
else
echo $#
for arg in "$@";
    do
    echo "$arg";
done
fi

