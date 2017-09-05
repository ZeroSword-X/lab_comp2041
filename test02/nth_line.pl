#!/usr/bin/perl -w

open F, "<", "$ARGV[1]";

$n = $ARGV[0];

$count = 0;
@lines = ();
while($line = <F>) {
   push @lines, $line;
   $count++;
}

if($n <= $count && $n > 0) {
   print "$lines[$n-1]";
}
