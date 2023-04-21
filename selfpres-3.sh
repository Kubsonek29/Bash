#!bin/bash
a=0
tab=(p1 p2 p3)
for arg in $@
do
    if [ $arg == "-b" ]
    then
    let a=a+1
    fi
done
if [ $a == 1 ]
then
for (( i=2;i<=$#;i++ ))
    do
        echo "==${!i}=="
        let tmp=$(($i))
    done
    if [ "$#" -ne 4 ]
    then
        for (( i=$tmp;i<4;i++ ))
        do
        echo "==${tab[l-1]}=="
        done
    fi
else
for (( i=1;i<=3;i++ ))
    do
        if [ "${!i}" != '' ]
        then
        echo "==${!i}=="
        else
        echo "==${tab[i-1]}=="
        fi
    done
fi