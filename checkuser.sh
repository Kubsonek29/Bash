#!/bin/bash
if [[ ( $1 = "" ) ]]; then
echo "Uzycie: ./checkuser.sh user"
elif [[ ( $1 == $USER ) ]]; then
echo "$1 jest wlascicielem powloki"
else
echo "$1 NIE jest wlascicielem powloki"
fi
