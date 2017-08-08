#!/bin/sh

first_Letter=`echo "$1" | cut -c1`

#Get the course list from the undergraduate handbook first
courses=`wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=$first_Letter" | egrep $1 | egrep '\<TD' | sed -e 's/<[^<>]*>//g' -e 's/\t//g'` 

output=""

for i in $courses
do
	echo "$i" | egrep "$1[0-9]{4}" &> /dev/null

	if [ $? -eq 0 ] 
	then
		if [ "$output" == "" ]
		then
    		output="$i"
		else
			output="$output"$'\n'"$i"
		fi
	else
		output="$output $i"
	fi
done

#Get the course list from postgraduate handbook
courses=`wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=$first_Letter" | egrep $1 | egrep "\<TD" | sed -e 's/<[^<>]*>//g' -e 's/\t//g'` 

for i in $courses
do
	echo "$i" | egrep "$1[0-9]{4}" &> /dev/null

	if [ $? -eq 0 ] 
	then
		if [ "$output" == "" ]
		then
    		output="$i"
		else
			output="$output"$'\n'"$i"
		fi
	else
		output="$output $i"
	fi
done

echo "$output" | sort | uniq
