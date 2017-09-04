#!/usr/bin/perl -w

$word = lc $ARGV[0];
$count = 0;

while($line = <STDIN>) {
   undef @words;
   $line = lc $line;

   @words = ($line =~ /\b$word\b/g);
   $count += @words;
}

print "$word occurred $count times\n";
