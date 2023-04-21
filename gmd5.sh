#!/bin/bash

while read user password
do
echo "$user $password $(echo -n $password | md5sum | cut -f1 -d ' ')"
done < "$1"
####