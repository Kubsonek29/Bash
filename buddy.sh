#!/bin/bash

i=0
skrypt='cat /proc/buddyinfo'
plik=''
node='Normal'
zone='Node 0'

while getopts ":asf:n:z:" arg; do
    case ${arg} in
    s) i=1;;
    f) plik="$OPTARG";;
    z) node="$OPTARG";;
    n) zone="$OPTARG";;
    a) ;;
    esac
done
shift $((OPTIND-1))

[[ -n $plik ]] && skrypt="cat $plik"
zone="$zone,"
zone=`echo $zone | awk -F " " '{if($1=="Node") {print $2}}'`
[[ $i == 1 ]] && $skrypt | awk -F " " '{ for(i=5;i<=NF;i++) {if($2=="'$zone'" && $4=="'$node'") {printf("%d %d %.2f\n",i-5,$i,2^(i-5)*4096*$i/2^20);a+=2^(i-5)*4096*$i/2^20}}} END{printf("%.2f\n",a)}' 
[[ $i == 0  && -n $1 ]] && $skrypt | awk -F " " '{ for(i=5;i<=NF;i++) {if($2=="'$zone'" && $4=="'$node'") {printf("%d %d %.2f\n",i-5,$i,2^(i-5)*4096*$i/2^20);a+=2^(i-5)*4096*$i/2^20}}}' | awk '{if($1=="'$1'") {print}}'

#//////////////////////////////////////////////////////////////////////////// 2^5 * 4096 * 68 / 2^20 = 8,50
#

