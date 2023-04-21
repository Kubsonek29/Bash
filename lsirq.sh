#!/bin/bash

i=0
skrypt='cat /proc/interrupts'
plik=''

while getopts ":sf:" arg; do
    case ${arg} in
    s) i=1;;
    f) plik="$OPTARG";;
    esac
done
shift $((OPTIND-1))

[[ -n $plik ]] && skrypt="cat $plik"

j=`$skrypt | awk '{ if (NR==1) {print}}' | sed 's/[^C]//g' | awk '{ {print length} }'`

if [[ $i == 0 ]]; then
#paste <($skrypt | tail -n +2 | awk -F " " '{ for(k=2; k<='$j'+1; k++) { if(k!='$j'+1) print $k; else print $k,"#" }}' | tr '\n' ' ' | tr '#' '\n') <($skrypt | tail -n +2 | awk -F " " '{print gsub(":","",$1), $NF}')
$skrypt | awk -v x=$j '$1 ~ /^[0-9]+:/{for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,$1,$NF;a=0}'
$skrypt | awk -v x=$j '$1 ~ /LOC:/ {for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,"Local timer interrupts"}'
else
#paste <($skrypt | tail -n +2 | awk -F " " '{ for(k=2; k<='$j'+1; k++) { if(k!='$j'+1) print $k; else print $k,"#" }}' | tr '\n' ' ' | tr '#' '\n') <($skrypt | tail -n +2 | awk -F " " '{print gsub(":","",$1), $NF}') | sort -n -k 1 -r
$skrypt | awk -v x=$j '$1 ~ /^[0-9]+:/ {for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,$1,$NF;a=0}' | sort -n -k 1 -r
$skrypt | awk -v x=$j '$1 ~ /LOC:/ {for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,"Local timer interrupts"}'
fi

###
#awk -v x=$j `$1 ~ /^[0-9]+:/{for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,$1,$NF}` "$plik"
#awk -v x=$j `$1 == /"LOC":/{for(i=2;i<=x+1;i++) a+=$i; gsub(":","",$1); print a,$1,"Local timer interrupts"}` "$plik"