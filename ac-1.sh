#!/bin/bash

echo $(ac -p | grep -v '\<total\>\|\<root\>' | LC_ALL=C sort -k2 -n -r | head -n 1)
