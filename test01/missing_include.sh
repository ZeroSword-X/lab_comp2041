#!/bin/sh

for f in $@
do
   name=`egrep '\#include \"' "$f" | sed -e 's/^#include \"\(.\+\)\"$/\1/g'`

   for line in $name
   do
      if ! test -e "$line"
      then
         printf "%s included into %s does not exist\n" "$line" "$f"
      fi
   done
done
