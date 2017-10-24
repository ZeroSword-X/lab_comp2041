#!/bin/sh

first=$1
last=$2

rm -rf "$3"

while [ $first -le $last ]
do
   echo $first >> "$3"
   first=$((first + 1))
done
