#!/bin/bash

# jk: Skrypt w obecnej wersji zlicza liczę procesów cieżkich w
# poszczególnych staniach. Proszę zauważyć, że zadania mówi nie o procesach
# ciężkich, ale zadaniach (tasks). Dlatego analizowane są dane uzyskane
# przez powyższą komendę, która pozwala określić, ile procesów lekkich
# wchodzi w skład jednego procesu (nlwp).

plik=""
user=""
skrypt='ps -e -o user,s,pid,tgid,lwp,nlwp,rss,args'
while getopts ":f:u:" arg; do
    case ${arg} in
    f) plik="$OPTARG";;
    u) user="$OPTARG";;
    esac
done
shift $((OPTIND-1))

[[ -n $plik ]] && skrypt="cat $plik"
[[ -n $user ]] && $skrypt | tail -n +2 | awk '{if($1=="'$user'"){print}}' | awk '{print $2, $6}' | awk 'BEGIN{s=0;t=0;d=0;r=0;z=0}{if($1=="S"){s+=$2}; if($1=="T"){t+=$2}; if($1=="D"){d+=$2}; if($1=="R"){r+=$2}; if($1=="Z"){Z+=$2}}END{printf("I=%d\n",i); printf("R=%d\n",r); printf("S=%d\n",s); printf("T=%d\n",t); printf("Z=%d\n",z)} ' || $skrypt | tail -n +2 | awk '{print $2, $6}' | awk 'BEGIN{s=0;t=0;d=0;r=0;z=0}{if($1=="S"){s+=$2}; if($1=="T"){t+=$2}; if($1=="D"){d+=$2}; if($1=="R"){r+=$2}; if($1=="Z"){Z+=$2}}END{printf("I=%d\n",i); printf("R=%d\n",r); printf("S=%d\n",s); printf("T=%d\n",t); printf("Z=%d\n",z)} '
