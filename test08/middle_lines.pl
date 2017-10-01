#!/usr/bin/perl -w

$file = $ARGV[0];
open F, "<", "$file";

while ($line = <F>) {
   push @lines, $line; 
}
close F;

if (@lines) {
   $n = @lines;
   
   if ($n % 2 == 1) {
      $n = int($n/2);
      print "$lines[$n]";
   } else {
      $n = int($n/2);
      print "$lines[$n-1]";
      print "$lines[$n]";
   }
}
