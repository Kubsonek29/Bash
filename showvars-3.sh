#!/bin/bash
if [[ ( $1 == "USER") ]]; then
echo "USER=$USER"
elif [[ ( $1 == "HOME" ) ]]; then
echo "HOME=$HOME" 
elif [[ ( $1 == "" ) ]]; then
echo "brak argumentu"
else
echo "nieznana zmienna"
fi