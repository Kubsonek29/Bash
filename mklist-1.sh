#!/bin/bash
i=''

if [[ -n $2 ]]; then
    i="$2"
    awk -F: '{if ($3>=999) {print $5}}' $1 | awk '{print $2, $1}' | grep -i "^$i"
else
    awk -F: '{if ($3>=999) {print $5}}' $1 | awk '{print $2, $1}'
fi


### awk -F: 'if($3>=999) {print $5}'
# | awk '{print $NF,$1}' | grep -i ^"$i"
###
#awk -F: '{if ($3>=999) {print $5}}' /etc/passwd | awk '{print $2, $1}' | grep -i "^[s-S]"
#awk -F: '{if ($3>=999) {print $5}}' /etc/passwd | awk '{print $2, $1}' | grep -i "^s"