#!/bin/sh


echo "\nupgrade template start"
git pull 
echo "upgrade template end\n"

sleep 1s 


sh ./execscript.sh "$@"