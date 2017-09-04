#!/usr/bin/perl -w

$num_words = 0;
while($line = <STDIN>) {
   undef @words;

   $line =~ s/^[^a-zA-Z]+//;
   @words = split(/[^a-zA-Z]+/, $line);
   $num_words += @words;
}

print "$num_words words\n";
