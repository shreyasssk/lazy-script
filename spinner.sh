#!/bin/bash
sudo apt-get update > /dev/null & PID=$! #simulate a long process

echo "THIS MAY TAKE A WHILE, PLEASE BE PATIENT WHILE ______ IS RUNNING..."
printf "["
# While process is running...
while kill -0 $PID 2> /dev/null; do 
    printf  "▓"
    sleep 1
done
printf "] done!"

#echo "Updating..."; (sudo apt-get update) & spinner > /dev/null; echo " done.";
