#!/bin/bash

c="head"
h="tail"

for arg in $@;
do
    if [[ $arg == "-r" ]]; then
    c="tail"
    h="head"
    shift
    fi
done

d="$1"
for arg in $@;
do
    if [[ $arg == $1 ]]; then
        d="$1"
        continue
    fi
    e="$arg"
    echo "$($c -n $e $d | $h -n 1)" # no work
done



#head -n $n $plik | tail -n 1
#sed -n ${n}p $plik
#awk -v n=$n 'NR==n' $plik #numer linii NR numer kolumny NF
#readarray tab < $
#echo ${tab[n]}