#!/usr/bin/perl -w

while ($line = <STDIN>) {
   chomp $line;
   
   @words = split(/\s+/, $line);
   @words = sort {$a cmp $b} @words;
   print "@words\n";
}
