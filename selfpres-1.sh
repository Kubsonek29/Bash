#!/bin/bash
echo "selfpres-1"
echo $#
if [[ ( $# == 3 ) ]]; then
echo "Arguments may be printed using iterative instruction"
echo "for ..."

for arg in "$@";
    do
    echo "$arg";
done

echo 'while [[ $# -gt 0 ]] ...'
i=1
while [[ $i -le $# ]]
do
     printf '%s\n' "${!i}"
     let i=i+1
done
i=1
echo 'while (( $# > 0 )) ...'
while (( $i <= $# ))
do
  printf '%s\n' "${!i}"
     let i=i+1
done
echo 'until ...'
i=1
until [ $i -gt $# ]
do
 printf '%s\n' "${!i}"
     let i=i+1
done
fi
if [[ ( $# -lt 3 ) ]]; then
echo "This script needs at least 3 command-line arguments!"
exit 0
fi
