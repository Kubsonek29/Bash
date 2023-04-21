#!/bin/bash

ls -l /dev4d | awk -F" " '{if(substr($1,1,1)=="b" && $5 == "'$1',"){printf("%c %d %d /dev4d/%s\n",substr($1,1,1),$5,$6,$10)}}' | sort -k 3n
ls -l /dev4d | awk -F" " '{if(substr($1,1,1)=="c" && $5 == "'$1',"){printf("%c %d %d /dev4d/%s\n",substr($1,1,1),$5,$6,$10)}}' | sort -k 3n 


#
#katalog=/dev
#
#if [ -d /dev4d ]; then
#    katalog=/dev4d
#fi#
#
#pliki=$(find ${katalog} -type b)#
#
#
#ls -l ${pliki} | tr -s ' ' | cut -d ' ' -f 1,5,6,10 | while read typ ng nd sciezka
#do
 #   if [ "$1," == "$ng" ]; then
  #      echo ${typ:0:1} ${ng%,} ${nd} ${sciezka}
   # fi
#done | sort -k 3 -n #wokol 3 kolumny

#tr -s // usuwa powtorzeni i zamienia na 1 tylko
#bash -x ###debug

#awk version

#pliki=$(find ${katalog} -type b)

#ls -l ${pliki} | awk '$5=="'$1'," {print $1,$5,$6,$9}' #itd


