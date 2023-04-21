#!/bin/bash

for arg in $@
do
if [[ "$(file $arg)" != *"text"* ]]
then
echo "$(basename $arg) is not a text file ... skipping ..."
else
echo ""
echo "plik $(basename $arg): HEAD"
echo "--------------------------------"
head -10 $arg
echo ""
echo "plik $(basename $arg): TAIL"
echo "--------------------------------"
tail -10 $arg 
fi
echo "======================================================================="
echo ""
done