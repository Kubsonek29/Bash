#!/bin/bash
if [[  ( $1 = "" ) ]]; then
echo "Uzycie: $(basename $0) user"
elif [[ ( "$(id $1)" != "id: $1: no such user" ) ]]; then
paste <(id -G $1 | tr ' ' '\n' ) <(id -Gn $1 | tr ' ' '\n' ) # <) podmienia na tymczasowy plik 
fi