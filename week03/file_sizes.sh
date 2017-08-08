#!/bin/sh

list=`ls`
small_Files=""
medium_Files=""
large_Files=""

for file in $list
do
	test -f $file

	if [ $? -eq 0 ]
	then
		num_lines=`wc -l $file | cut -d' ' -f1`
		if [ $num_lines -ge 100 ]
		then
			large_Files="$large_Files $file"			
		elif [ $num_lines -ge 10 ]
		then
			medium_Files="$medium_Files $file"			
		else
			small_Files="$small_Files $file"			
		fi
	fi
done

echo "Small files:$small_Files"
echo "Medium-sized files:$medium_Files"
echo "Large files:$large_Files"
