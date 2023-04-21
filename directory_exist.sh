#!/bin/bash
echo "directory name=$1"
if [ -d "$1" ]
then
echo "Directory exist"
else
`mkdir $1`
echo "Directory created"
fi