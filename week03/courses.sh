#!/bin/sh

#IFS="$"

list=`wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=O" | grep OPTM | sed -e 's/<[^<>]*>//g' | sed -e 's/\t//g'`

for line in "$list"
do
	echo "1"
done
