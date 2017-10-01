#!/usr/bin/perl -w

while ($line = <STDIN>) {
   push @lines, $line;

   @numbers = ();
   (@numbers) = ($line =~ /-?\.\d+|-?\d+\.\d+|-?\d+/g);

   foreach $n (@numbers) {
      if (!defined $max) {
         $max = $n;
      } else {
         if ($n > $max) {
            $max = $n;
         }
      }
   }
}

if (defined $max) {
   foreach $line (@lines) {
      if ($line =~ /$max/) {
         print "$line";
      }
   }
}
