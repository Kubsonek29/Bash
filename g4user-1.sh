#!/bin/bash

if [[  ( $1 = "" ) ]]; then
echo "Uzycie: $(basename $0) user"
elif [[ ( "$(id $1)" != "id: $1: no such user" ) ]]; then
echo "$(id -G $1)"
echo "$(id -Gn $1)"
fi