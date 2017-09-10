#!/usr/bin/perl -w


foreach $word (@ARGV) {
   if (!defined $list{$word}) {
      $list{$word} = 1;
      print "$word ";
   } 
}

print "\n";
