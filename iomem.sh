#!/bin/bash

i=0

while getopts "mg" arg; do
    case ${arg} in
    m) i=1;;
    g) i=2;;
    esac
done
shift $((OPTIND-1))

x=`awk -F " : " '{print $1}' /proc/iomem | tr a-f A-F` #nowork
a=`echo "ibase=16; $x" | bc | tr ' ' '\n' ` #to B
if [ $i == 1 ]; then
    paste <(awk -F " : " '{print $2":"}' /proc/iomem) <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}')  <(echo "scale=8; $(awk '{print $1"/1024/1024"}' <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}'))" | bc | awk '{printf "%.4f MB\n", $0}') | tr '-' ' '  
else if [ $i == 2 ]; then
    paste <(awk -F " : " '{print $2":"}' /proc/iomem) <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}')  <(echo "scale=8; $(awk '{print $1"/1024/1024/1024"}' <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}'))" | bc | awk '{printf "%.4f GB\n", $0}') | tr '-' ' '  
else
    paste <(awk -F " : " '{print $2":"}' /proc/iomem) <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}')  <(echo "scale=8; $(awk '{print $1"/1024"}' <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}'))" | bc | awk '{printf "%.4f KB\n", $0}') | tr '-' ' '  
fi
fi





#echo "scale=4; $(awk '{print $1"/1024"}' <(echo "ibase=16; $x" | bc | awk '{print $0 " B"}'))" | bc | awk '{print $0 " KB"}'


#tmp=`paste <(awk -F: '{print $2}' /proc/iomem) <(awk -F: '{print $1}' /proc/iomem | tr a-f A-F)`
#echo $tmp
#cat /proc/iomem | tr a-f A-F
#echo "ibase=16; 11A0000000" | bc
#paste <(id -G $1 | tr ' ' '\n' ) <(id -Gn $1 | tr ' ' '\n' ) # <) podmienia na tymczasowy plik 