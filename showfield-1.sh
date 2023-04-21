#!/bin/bash

sep=" "
plik=''

while getopts ":d:f:" opt
do
    case $opt in
    d) sep="$OPTARG";;
    f) plik="$OPTARG";;
    esac
done
shift $((OPTIND-1))

skrypt="{ print "
for i in $@;
do
    skrypt="$skrypt\$$i,\" $sep \""
    #skrypt="$(skrypt)\" $(sep) \"\$$i"
done 
#echo "$skrypt}"
awk -F "$sep" "$(echo "$skrypt}")" "$plik"
#awk -F "$sep" "(print $skrypt}" "$plik"
###


#awk -F: '{print $1}' # : to separator
#awk -F "lala" '{print $1 " " $2}' # lala to separator

