#!/bin/bash

i=0
skrypt='ps -eo user,uid,pmem,pcpu,comm'
plik=''

while getopts "suf:" arg; do
    case ${arg} in
    s) i=1;;
    u) i=2;;
    f) plik="$OPTARG";;
    esac
done
shift $((OPTIND-1))

if [[ -n $plik ]]; then
    skrypt="cat $plik"
fi

if [[ $i == 0 ]]; then
paste <($skrypt | tail -n +2 | awk '{print $1}' | awk '{ a[$1]++ } END{ for(x in a) print a[x], x }' | awk '{print $2, $1}' | sort -u)  <($skrypt | tail -n +2 | awk '{ seen[$1] += $4 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') <($skrypt | tail -n +2 | awk '{ seen[$1] += $3 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') | sort -n -k 3 -r | expand -t 15
else if [[ $i == 1 ]]; then
paste <($skrypt | tail -n +2 | awk '{if ($2<=999) {print $1}}' | awk '{ a[$1]++ } END{ for(x in a) print a[x], x }' | awk '{print $2, $1}' | sort -u)  <($skrypt | tail -n +2 | awk '{if ($2<=999) {print}}' | awk '{ seen[$1] += $4 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') <($skrypt | tail -n +2 | awk '{if ($2<=999) {print}}' | awk '{ seen[$1] += $3 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') | sort -n -k 3 -r | expand -t 15
else if [[ $i == 2 ]]; then
paste <($skrypt | tail -n +2 | awk '{if ($2>999) {print $1}}' | awk '{ a[$1]++ } END{ for(x in a) print a[x], x }' | awk '{print $2, $1}' | sort -u)  <($skrypt | tail -n +2 | awk '{if ($2>999) {print}}' | awk '{ seen[$1] += $4 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') <($skrypt | tail -n +2 | awk '{if ($2>999) {print}}' | awk '{ seen[$1] += $3 } END { for (i in seen) print i,seen[i] }' | sort -u | awk '{print $2}') | sort -n -k 3 -r | expand -t 15
fi
fi
fi
### change a[$1]++ na a[$0]++ #change >= -> >

#  | awk '{print $1}' | awk '{ a[$0]++ } END{ for(x in a) print a[x], x }' ####zlicza powtorzenia
#  | awk '{ a[$0]++ } END{ for(x in a) print a[x], x }' 
#  | awk '{ seen[$1] += $3 } END { for (i in seen) print i,seen[i] }' ####liczy cpu
#$skrypt | tail -n +2 | sort -n -k 3 -r | awk -F " " '{print $1, $2, $3, $4}'



#ps -eo user,uid,pmem,pcpu,comm | sort -k 4 -r | sort -k 3 -r
#ps -eo user,uid,pmem,pcpu,comm | sort -k 4 -r | sort -k 3 -r | awk -F " " '{if ($2<999) {print}}'
#ps -eo user,uid,pmem,pcpu,comm | sort -k 4 -r | sort -k 3 -r | awk -F " " '{if ($2>999) {print}}'


#declare -ar LIST=(bread milk eggs) ${#LIST[@]}
