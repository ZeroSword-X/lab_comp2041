#!/bin/sh

if [ $# -ne 2 ]
then
	echo 'Usage: ./echon.sh <number of lines> <string>'
	exit 1
fi

test "$1" -ge 0 &> /dev/null
if [ $? -ne 0 ]
then
	echo './echon.sh: argument 1 must be a non-negative integer'
	exit 1
fi



counter=0
while [ $counter -lt $1 ]
do
    echo "$2"
	counter=`expr $counter + 1`
done

