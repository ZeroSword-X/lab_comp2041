#!/bin/sh


for f in *.htm
do
   name=`printf "%s" "$f" | cut -d'.' -f1`
   html_file="$name.html"

   if test -e "$html_file"
   then
      printf "%s exists\n" "$html_file" >&2
      exit 1
   fi

   mv -- "$f" "$html_file" 
done
