#!/usr/bin/perl -w

if ($#ARGV + 1 != 2) {
   print STDERR "Usage: ./echon.pl <number of lines> <string>\n";
   exit 1;
} elsif($ARGV[0] !~ /^\d+$/) {
   print STDERR "$0: argument 1 must be a non-negative integer\n";
   exit 1;
}


for (1..$ARGV[0]) {
   print "$ARGV[1]\n";
}
