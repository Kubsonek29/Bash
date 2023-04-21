#!/bin/bash

if [[ ($# == 3 ) ]];then
echo "All three positional parameters given: $@. Exiting with error code 0."
exit 0
elif [[ ( $# == 2 ) ]]; then
echo 'Missing $3. Exiting with error code 1.'
exit 1
elif [[ ( $# == 1 ) ]]; then
echo 'Missing $2 and $3. Exiting with error code 2.'
exit 2
elif [[ ( $# == 0 ) ]]; then
echo 'Missing $1, $2 and $3. Exiting with error code 3.'
exit 3
fi