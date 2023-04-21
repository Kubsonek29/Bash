#!/bin/bash
file='/etc/os-release'
echo "read file=$file"
while read line; do
echo $line
done < $file