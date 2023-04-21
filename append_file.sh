#!/bin/bash
elek="/etc/os-release"
echo "appending file=$elek"
echo "Before appending the file"
cat $elek
echo "Learning Level 5">> $elek
echo "After appending the file"
cat $elek