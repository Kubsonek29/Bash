#!/bin/bash

i=3
skrypt='ps -eo user,vsz,rsz,pcpu,comm'
plik=''

while getopts ":n:f:" arg; do
    case ${arg} in
    n) i="$OPTARG";;
    f) plik="$OPTARG";;
    esac
done
shift $((OPTIND-1))

if [[ -n $plik ]]; then
    skrypt="cat $plik"
fi

#i=$((i+1))

echo "CPU hogs:"
$skrypt | tail -n +2 | sort -n -k 4 -r  | awk -F " " -v var="$i" '{if (NR<=var) {print}}' | awk '{{printf $1 " "} {printf "%.1f ",$4} {printf $5 " \n"}}'
echo ""
echo "RES hogs:"
$skrypt | tail -n +2 | sort -n -k 3 -r | awk -F " " -v var="$i" '{if (NR<=var) {print}}' | awk '{{printf $1 " "} {printf $3 " "} {printf $5 " \n"}}'
echo ""
echo "VIRT hogs:"
$skrypt | tail -n +2 | sort -n -k 2 -r | awk -F " " -v var="$i" '{if (NR<=var) {print}}' | awk '{{printf $1 " "} {printf $2 " "} {printf $5 " \n"}}'

##
#$skrypt | tail -n +2 | sort -n -k 3 -r | awk -F " " -v var="$i" '{if (NR<=var) {print}}' | awk '{print $1, $3, $5}'
#$skrypt | sort -k 4 -r | sort -k 3 -r | awk -F " " '{if (NR!=1 && $i<$NR) {print}}'
# vsz=2 rsz=3 cpu=4
# ps -eo user,vsz,rsz,pcpu,comm | tail -n +2 | sort -n  -k 3 -r --debug