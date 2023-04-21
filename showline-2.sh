#!/bin/bash

c=0

for arg in $@;
do
    if [[ $arg == "-r" ]]; then
    c=1
    shift
    fi
done

d="$1"

tmp=$(cat $1 | wc -l)

for arg in $@;
do
    if [[ $arg == "0" ]]; then
        echo "Niepoprawny argument: numer linii musi byc rozny od 0."
        break;
    fi
    if [[ $arg == $1 ]]; then
        d="$1"
        continue
    fi
    e="$arg"
    if [[ $c == 1 ]]; then
        awk -v n=$(expr $tmp - $arg) 'NR==n' $1
    else
        awk -v n=$e 'NR==n' $1
    fi
done



#head -n $n $plik | tail -n 1
#sed -n ${n}p $plik
#awk -v n=$n 'NR==n' $plik #numer linii NR numer kolumny NF
#readarray tab < $
#echo ${tab[n]}