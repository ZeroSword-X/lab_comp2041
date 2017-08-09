#!/bin/sh

list=`ls`
small_Files=""
medium_Files=""
large_Files=""

for file in $list
do
   if test -f $file
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

printf "Small files:%b\n" "$small_Files"
printf "Medium-sized files:%b\n" "$medium_Files"
printf "Large files:%b\n" "$large_Files"
