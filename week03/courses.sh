#!/bin/sh

# Check if the argument is valid
if [ $# -ne 1 ] 
then
   # The number of argument is not equal to ONE
   printf "%s\n" "Usage: ./courses.sh <STREAM>"
   exit 1
else
   # if the argument is less than or greater than 4 capital characters, either do a padding or truncate
   if printf "%s" "$1" | egrep "^[A-Z]{4}$" &> /dev/null
   then
      arg="$1"
   elif printf "%s" "$1" | egrep "^[A-Z]{1,3}$" &> /dev/null
   then
      num_char=`printf "%s" "$1" | wc -c `
      padding=`expr 4 - $num_char`
      arg="$1[A-Z]{$padding}"
   elif printf "%s" "$1" | egrep "^[A-Z]{5,}$" &> /dev/null
   then
      arg=`printf "%s" "$1" | cut -c1-4 `
   else
      printf "%s\n" "Invalid argument"
      printf "%s\n" "Usage: ./courses.sh <STREAM>"
      exit 1
   fi 
fi


# Get the first letter of argument 1
first_Letter=`printf "%s" "$arg" | cut -c1`

#Get the course list from the undergraduate handbook first
under=`wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=$first_Letter" | egrep "$arg" | egrep '\<TD' | sed -e 's/<[^<>]*>//g' -e 's/\t//g'` 

#Get the course list from the postgraduate handbook
post=`wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=$first_Letter" | egrep "$arg" | egrep '\<TD' | sed -e 's/<[^<>]*>//g' -e 's/\t//g'` 

# Combine the two lists into a single course list
courses="$under $post"
output=""

for i in $courses
do
   if printf "%s" "$i" | egrep "$arg[0-9]{4}" &> /dev/null
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
