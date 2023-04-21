#!/bin/bash
elek=`date -d 2/02/2021`
lelek=`date +%T -d 0`
echo "$elek"
echo "Current Date is: "$(date -d 02/02/2021 '+%d-%m-%Y')
echo "Current Time is: $lelek"