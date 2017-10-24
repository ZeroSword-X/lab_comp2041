#!/usr/bin/perl -w

use strict;

my @numbers = ();

while (my $line = <STDIN>) {
   my (@array) = ($line =~ /\d+/g);

   foreach my $num (@array) {
      push @numbers, $num;
   }
}

@numbers = sort {$a <=> $b} @numbers;

my @indivisibles = ();

foreach my $num1 (@numbers) {
   my $divisible = 0;
   my $repeated = 0;

   foreach my $num2 (@numbers) {
      last if ($num1 < $num2);
  
      if ($num1 == $num2) {
         if (! $repeated) {
            $repeated = 1;
            next;
         }
      }
 
      if ($num1 % $num2 == 0) {
         $divisible = 1;
         last;
      }
   }

   if (! $divisible) {
      push @indivisibles, $num1;
   }
}

print "@indivisibles\n";
