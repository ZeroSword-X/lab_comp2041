#!/bin/sh

if [ $# -ne 2 ]
then
	printf 'Usage: ./echon.sh <number of lines> <string>\n'
	exit 1
elif ! test "$1" -ge 0 &> /dev/null
then
	printf './echon.sh: argument 1 must be a non-negative integer\n'
	exit 1
fi

counter=0
   
while [ $counter -lt $1 ]
do
   echo "$2"
   counter=`expr $counter + 1`
done
