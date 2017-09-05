#!/usr/bin/perl -w

while($line = <STDIN>) {
   chomp $line;

   $line =~ s/\d+//g;
   print "$line\n" 
}
