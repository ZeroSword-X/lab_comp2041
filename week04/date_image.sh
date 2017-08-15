#!/bin/sh

if [ $# -eq 0 ]
then
   printf "Usage: ./date_image.sh <Image file(s)>\n" >&2
   exit 1
fi

exit_status=0

for image in "$@"
do
   if ! test -e "$image" 
   then
      printf "\'$image\' does not exist !\n" >&2
      exit_status=1
      continue
   fi

   # image is just a back up where image.tmp will be annotated
   cp -p "$image" "$image.tmp" 

   taken_month=`ls -l "$image" | sed -e 's/ \+/ /g' | cut -d' ' -f6`
   taken_day=`ls -l "$image" | sed -e 's/ \+/ /g'| cut -d' ' -f7`
   taken_time=`ls -l "$image" | sed -e 's/ \+/ /g' | cut -d' ' -f8`
   annotation="$taken_month $taken_day $taken_time"

   num_bytes=`printf "%s" "$annotation" | wc -c`
   num_bytes=`expr $num_bytes - 1`
   
   if convert -gravity south -pointsize 36 -draw "text 0,$num_bytes '$annotation'" "$image.tmp" "$image.final"
   then
      # successfully add annotation
      touch -r "$image" "$image.final"
      mv -- "$image.final" "$image"    #overwrite the original image
      rm -- "$image.tmp"
   else 
      printf "%s cannot be annotated !\n" "$image" >&2
      rm -rf -- "$image.tmp" "$image.final"
      exit_status=1
      continue
   fi 
done

exit $exit_status
