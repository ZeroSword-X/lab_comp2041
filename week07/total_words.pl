#!/usr/bin/perl -w

$num_words = 0;
while($line = <STDIN>) {
   undef @words;

   @words = split(/[^a-zA-Z]+/, $line);

   foreach $word (@words) {
      if($word) {
         $num_words++;
      }
   }
}

print "$num_words words\n";
