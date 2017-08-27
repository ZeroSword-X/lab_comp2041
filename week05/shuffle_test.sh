#!/bin/sh

tmp1="/tmp/TMP1_$$"
tmp2="/tmp/TMP2_$$"

seq 0 4 | ./shuffle.pl > $tmp1
seq 0 4  > $tmp2

if diff $tmp1 $tmp2 &> /dev/null
then
   printf "shuffle.pl does not shuffle the lines for a given input !\n"
   printf "Try again ! Sometimes it is possible to have two identical \'random\' outputs ......\n"
else
   printf "shuffle.pl shuffles the lines for a given input !\n" 
   printf "Now testing the correct output ......\n"

   # Sort the output of shuffle.pl, and the compare it with the correct output
   # The reason why I do not compare it with all the possible outputs generated is bacause
   # it takes too much time to generate all possible results if the input is relatively large 
   seq 0 4 | ./shuffle.pl | sort > $tmp1
   seq 0 4 | sort > $tmp2

   if diff $tmp1 $tmp2 &> /dev/null
   then
      printf "shuffle.pl produces the correct output !\n"
   else
      printf "shuffle.pl does not produce the correct output !\n"
   fi
fi

rm -rf $tmp1 $tmp2
