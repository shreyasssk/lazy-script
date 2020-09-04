#!/bin/bash

spinner(){
$1 > /dev/null & PID=$!

spin[0]="-"
spin[1]="\\"
spin[2]="|"
spin[3]="/"

trap "kill $pid 2> /dev/null" EXIT

while kill -0 $PID 2> /dev/null; do
for i in "${spin[@]}"
do
    echo -ne "\b$i"
    sleep 0.1
done
done
}

printf "Updating  " & spinner "sudo apt-get update"; printf "\ndone.";
