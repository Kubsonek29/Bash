#!/bin/bash

i=0
skrypt='cat /etc/group'
plik=''

while getopts ":nf:" arg; do
    case ${arg} in
    n) i=1;;
    f) plik="$OPTARG";;
    esac
done
shift $((OPTIND-1))

[[ -n $plik ]] && skrypt="cat $plik"

paste <($skrypt | awk -F: '{print $1,$2,$3}' | tr ' ' ':') <($skrypt | awk -F : ' {split( $4, a, "," ); asort( a ); for( i = 1; i <= length(a); i++ ) printf( "%s ", a[i] ); printf( "\n" ); }' | tr ' ' ',') | tr '\t' ':'


###
#// 2^5 * 4096 * 68 / 2^20 = 8,50