#!/bin/sh

if [ $# -eq 0 ]
then
   printf "Usage: ./fix_id3_tags.sh <music file(s)>\n" >&2
   exit 1
fi


exit_status=0
TMP_FILE=/tmp/fix_id3_tags_tmp$$

for arg in "$@"
do
   if test -d "$arg"
   then
      # If the argument is a directory, use 'find' to locate all mp3 files under that directory and direct the stdout to a temp file
      find "$arg" -name '*.mp3' -print > $TMP_FILE

      while read line
      do
         album=`printf "%s" "$line" | cut -d'/' -f2`
         year=`printf "%s" "$album" | cut -d',' -f2 | cut -c2-`

         track=`printf "%s" "$line" | cut -d'/' -f3 | sed -e 's/^\(.\+\) - \(.\+\) - \(.\+\)$/\1/g'` 
         title=`printf "%s" "$line" | cut -d'/' -f3 | sed -e 's/^\(.\+\) - \(.\+\) - \(.\+\)$/\2/g'` 
         artist=`printf "%s" "$line" | cut -d'/' -f3 | sed -e 's/^\(.\+\) - \(.\+\) - \(.\+\)$/\3/g' -e 's/.mp3//g'` 

         id3 -a "$artist" -A "$album" -t "$title" -T "$track" -y "$year" "$line" &> /dev/null
      done < $TMP_FILE     

      rm -f $TMP_FILE
   elif test -e "$arg"
   then
      album=`printf "%s" "$arg" | cut -d'/' -f2`
      year=`printf "%s" "$album" | cut -d',' -f2 | cut -c2-`

      track=`printf "%s" "$arg" | cut -d'/' -f3 | sed -e 's/^\(.\+\) - \(.\+\) - \(.\+\)$/\1/g'` 
      title=`printf "%s" "$arg" | cut -d'/' -f3 | sed -e 's/^\(.\+\) - \(.\+\) - \(.\+\)$/\2/g'` 
      artist=`printf "%s" "$arg" | cut -d'/' -f3 | sed -e 's/^\(.\+\) - \(.\+\) - \(.\+\)$/\3/g' -e 's/.mp3//g'` 

      id3 -a "$artist" -A "$album" -t "$title" -T "$track" -y "$year" "$arg" > /dev/null
   else
      printf "\'$arg\' does not exist !\n" >&2
      exit_status=1
   fi
done

exit $exit_status
