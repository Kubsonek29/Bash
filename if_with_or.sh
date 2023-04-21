#!/bin/bash

if [[ ( $1 -eq 15 || $1  -eq 45 ) ]]
then
echo "number=$1 "
echo "You won the game"
else
echo "number=$1"
echo "You lost the game"
fi