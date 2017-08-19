#!/usr/bin/perl -w

while ($input = <STDIN>) {
   # split the stdin string into array
   @chars = split(//, $input);

   # traverse the array and do substitution
   foreach $c (@chars) {
      if ($c ge "0" && $c le "4") {
         $c = "<";
      } elsif ($c ge "6" && $c le "9") {
         $c = ">";
      }
   
      print "$c";
   }
}
