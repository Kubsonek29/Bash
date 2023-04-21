#!/bin/bash

plik=$1
i="$2"
j="$3"

[[ -n $1 ]] && skrypt="cat $1"
$skrypt | awk -F ":" -v i=$i -v j=$j ' { if( $7 == j && $3 > 999 ) { print $1":"$2":"$3":"$4":"$5":"$6":"j } else { print $1":"$2":"$3":"$4":"$5":"$6":"$7 }}'

