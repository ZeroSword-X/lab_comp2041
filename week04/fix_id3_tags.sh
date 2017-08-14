#!/bin/sh

if [ $# -eq 0 ]
then
   printf "Usage: ./fix_id3_tags.sh <music file(s)>\n"
   exit 1
fi

for arg in "$@"
do
   if test -d "$arg"
   then
      continue     
   elif test -e "$arg"
   then
      path=`printf "%s" "$arg" | sed -e 's/ - /-/g'`
      album=`printf "%s" "$path" | cut -d'/' -f2`
      year=`printf "%s" "$album" | cut -d',' -f2 | cut -c2-`

      track=`printf "%s" "$path" | cut -d'/' -f3 | cut -d'-' -f1` 
      title=`printf "%s" "$path" | cut -d'/' -f3 | cut -d'-' -f2` 
      artist=`printf "%s" "$path" | cut -d'/' -f3 | cut -d'-' -f3 | sed -e 's/.mp3//g'` 


      #printf "%s\n" "$album"
      #printf "%s\n" "$artist"
      #printf "%s\n" "$title"
   fi
done
