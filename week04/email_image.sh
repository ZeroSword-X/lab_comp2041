#!/bin/sh


if [ $# -eq 0 ]
then
   printf "Usage: ./email_image.sh <image file(s)>\n"
   exit 1
fi


exit_status=0

for image in "$@"
do
   if ! test -e "$image" 
   then
      printf "\'$image\' does not exist.\n"
      exit_status=1
      continue
   fi

   if display $image &> /dev/null
   then
      printf "Address to e-mail this image to? "
      read email

      if printf "%s" "$email" | egrep "^[a-zA-Z0-9_]+\@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+$" > /dev/null
      then
         printf "Message to accompany image? "
         read msg
         
         if printf "%s" "$msg" | mutt -s "UNSW COMP2041 Testing" -a "$image" -e set -- "$email" &> /dev/null
         then
            printf "$image sent to $email\n"
         else
            printf "Error: Unable to sent \'$image\'\n"
            exit_status=1
         fi
      else
         printf "$email is not a valid email address. $image will not be sent\n"
         exit_status=1
         continue
      fi

   else
      printf "\'$image\' cannot be displayed. The image will not be sent\n"
      exit_status=1
      continue
   fi
done

exit $exit_status
