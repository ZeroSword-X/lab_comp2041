#!/bin/sh

# If there is no jpg file, then just exit the shell script (with exit status 1)
if ! ls *.jpg &> /dev/null 
then
   exit 1
fi


exit_status=0

for image in *.jpg
do
   new_image=`printf "%s" "$image" | sed -e 's/.jpg/.png/g'`

   if test -e "$new_image"
   then
      # There is existing png image with the same name as $new_image
      # ignore it and processing the next argument
      printf "$new_image already exists\n" >&2
      exit_status=1  
      continue
   fi

   convert "$image" "$new_image" && rm -- "$image"
done

exit $exit_status
