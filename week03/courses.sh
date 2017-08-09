#!/bin/sh

if [ $# -ne 1 ]
then
	printf "%b\n" "Usage: ./courses.sh <STREAM>"
	exit 1
fi

# Get the first letter of argument 1
first_Letter=`echo "$1" | cut -c1`

#Get the course list from the undergraduate handbook first
under=`wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=$first_Letter" | egrep "$1" | egrep '\<TD' | sed -e 's/<[^<>]*>//g' -e 's/\t//g'` 
#Get the course list from the postgraduate handbook
post=`wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=$first_Letter" | egrep "$1" | egrep '\<TD' | sed -e 's/<[^<>]*>//g' -e 's/\t//g'` 

# Combine the two lists into a single course list
courses="$under $post"
output=""

for i in $courses
do
   if printf "%s\n" "$i" | egrep "$1[0-9]{4}" &> /dev/null
   then
      if [ "$output" == "" ]
      then
         output="$i"
      else
         output="$output\n$i"
      fi
   else
      output="$output $i"
   fi
done 

printf "%b\n" "$output" | sort | uniq
