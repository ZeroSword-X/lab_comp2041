#!/usr/bin/perl -w

if (@ARGV > 0) {
   @array = sort {$a <=> $b}  @ARGV;
   $index = @array / 2;
   print "$array[$index]\n";
} else {
   print "0\n";
}
