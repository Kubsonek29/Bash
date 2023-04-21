#!/bin/bash

while getopts ":r" arg; do
    case ${arg} in
    r) i=1 || i=0 ;;
    esac
done
shift $((OPTIND-1))
#echo "313034/OBIEKT1/wtmp/sos"
echo  "./OBIEKT1" | awk '{split($1,a,"/");k=length(a);i=1;j=1;
    for(;i<=k;i++){
        if(i==1){
            {print a[i]};
        }
        else if(i!=k){
            {print a[i]};
        }
        else{
            {print a[i]"&"};
            k=k-1;
            i=0;
            j++
        }
    }
    {print "&"}
}' | tr '\n' '/' | tr '&' '\n' | sed '$ d' | awk 'BEGIN{a=0} {if(a==0){print "/" $0}else if(a==NR-1){print substr($0,1,length($0)-1)}else{print $0};a++}' |
while read line
do
ls -id $line
done


#sed '$ d' #odcina ostatnia linijka