#!/usr/bin/perl -w

foreach $file (glob "lyrics/*.txt") {
   open F, "<", "$file" or die "$0: Can't open $file: $!";
   
   $artist = $file;
   $artist =~ s/lyrics\/(.*).txt/$1/;
   $artist =~ s/[^a-zA-Z]/ /g;

   while($line = <F>) {
      undef @words;
 
      $line = lc $line;
      $line =~ s/^[^a-zA-Z]+//;
      @words = split(/[^a-zA-Z]+/, $line);

      foreach $word (@words) {
         $bag{$artist}{$word}++;
         $n_words{$artist}++;
      }
   }

   close F;
}

if($ARGV[0] eq "-d") {
   shift @ARGV;
   $flag = 1;
} else {
   $flag = 0;
}

foreach $song (@ARGV) {
   open F, "<", "$song" or die "$0: Can't open $song: $!";
   undef %prob;

   while($line = <F>) {
      undef @words;

      $line = lc $line;
      $line =~ s/^[^a-zA-Z]+//;
      @words = split(/[^a-zA-Z]+/, $line);

      foreach $word (@words) {
         foreach $artist (keys %bag) {
            if(defined $bag{$artist}{$word}) {
               $prob{$artist} += log(($bag{$artist}{$word}+1)/$n_words{$artist});  
            } else {
               $prob{$artist} += log(1/$n_words{$artist});  
            }
         }
      }
   }

   @artists = sort{$prob{$b} <=> $prob{$a}} keys %prob;
   
   if($flag) {
      foreach $artist (@artists) {
         printf "$song: log_probability of %.1f for $artist\n", $prob{$artist};
      }
   }
   printf "$song most resembles the work of $artists[0] (log-probability=%.1f)\n", $prob{$artists[0]};
   close F;
}
