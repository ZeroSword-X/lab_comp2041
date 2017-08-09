#!/bin/sh

while read input
do
	printf "%b\n" "$input" | tr '0-4' '<' | tr '6-9' '>'
done
