#!/bin/sh

while read input
do
	echo "$input" | tr '0-4' '<' | tr '6-9' '>'
done
