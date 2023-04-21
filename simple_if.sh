#!/bin/bash
if [ $1 -lt 10 ];
then
echo "It is a one digit number"
fi

if [ $1 -gt 10 ];
then
echo "It is a two digit number"
fi

if [ $1 -z "$s" ];
then
echo "Number is missing"
fi
