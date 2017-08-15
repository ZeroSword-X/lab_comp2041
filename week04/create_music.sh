#!/bin/sh

if [ $# -ne 2 ]
then
   printf "Usage: ./create_music.sh <.mp3 file> <directory>\n" >&2
   exit 1
fi

if ! test -e "$1"
then
   printf "The mp3 file \'$1\' does not exist !!\n" >&2
   exit 1
fi

if test -d "$2"
then
   printf "The directory \'$2\' already exists !!\n" >&2
   exit 1
fi


mkdir "$2"
TMP_FILE=/tmp/create_music_tmp$$
wget -q -O- 'https://en.wikipedia.org/wiki/Triple_J_Hottest_100?action=raw' | egrep '\|[ ]?style=|^#' > $TMP_FILE

creating_Music=false
exit_status=0

album=""
artist=""
title=""
track=1

while read line
do
   if ! $creating_Music
   then
      if printf "%s" "$line" | egrep 'Triple J Hottest 100, [0-9]{4}' &> /dev/null
      then 
         if printf "%s" "$line" | egrep -v 'All time' &> /dev/null
         then
            creating_Music=true
            fullname=`printf "%s" "$line" | sed -e 's/.*\[\[\(.\+\)\]\].*/\1/g'`
            album=`printf "%s" "$fullname" | cut -d'|' -f1`

            mkdir "$2/$album"
         fi
      fi
   else
      if printf "%s" "$line" | egrep '^#' &> /dev/null
      then
         simplified_line=`printf "%s" "$line" | sed -e 's/\//-/g' -e 's/# //g' -e 's/#//g' -e 's/\[//g' -e 's/\]//g' -e 's/\"//g'`
         title=`printf "%s" "$simplified_line" | sed -e 's/\(.\+\) – \(.\+\)/\2/g' | cut -d'|' -f2`
         artist=`printf "%s" "$simplified_line" | sed -e 's/\(.\+\) – \(.\+\)/\1/g'`

         if printf "%s" "$artist" | egrep ' featuring ' &> /dev/null
         then
            first=`printf "%s" "$artist" | sed -e 's/\(.\+\) featuring \(.\+\)/\1/g'`
            last=`printf "%s" "$artist" | sed -e 's/\(.\+\) featuring \(.\+\)/\2/g'`
            
            if printf "%s" "$first" | egrep "\|" &> /dev/null
            then
               first=`printf "%s" "$first" | sed -e 's/.\+|\(.\+\)$/\1/g'` 
            fi

            if printf "%s" "$last" | egrep "\|" &> /dev/null
            then
               last=`printf "%s" "$last" | sed -e 's/.\+|\(.\+\)$/\1/g'`
            fi

            artist="$first featuring $last"

         elif printf "%s" "$artist" | egrep ' Featuring ' &> /dev/null
         then
            first=`printf "%s" "$artist" | sed -e 's/\(.\+\) Featuring \(.\+\)/\1/g'`
            last=`printf "%s" "$artist" | sed -e 's/\(.\+\) Featuring \(.\+\)/\2/g'`
            
            if printf "%s" "$first" | egrep "\|" &> /dev/null
            then
               first=`printf "%s" "$first" | sed -e 's/.\+|\(.\+\)$/\1/g'` 
            fi

            if printf "%s" "$last" | egrep "\|" &> /dev/null
            then
               last=`printf "%s" "$last" | sed -e 's/.\+|\(.\+\)$/\1/g'`
            fi

            artist="$first Featuring $last"

         elif printf "%s" "$artist" | egrep '\|' &> /dev/null
         then
            artist=`printf "%s" "$artist" | sed -e 's/.\+|\(.\+\)$/\1/g'`
         fi

         cp "$1" "$2/$album/$track - $title - $artist.mp3"
         
         if ! id3 -a "Andrew" -A "Best of Andrew" -t "Andrew Rocks" -T "42" -y "2038" "$2/$album/$track - $title - $artist.mp3" &> /dev/null
         then
            printf "Error occured when creating the music file %s.mp3 by using id3\n" "$2/$album/$track - $title - $artist" >&2
            exit_status=1
            break
         fi

         track=`expr $track + 1`

         if [ $track -gt 10 ]
         then
            track=1
            creating_Music=false
         fi
      else
         printf "%s\n" "$line" >&2
         printf "Error: The line is not started with \'#\'\n" >&2
         exit_status=1
         break
      fi 
   fi

done < $TMP_FILE

rm -rf $TMP_FILE
exit $exit_status
