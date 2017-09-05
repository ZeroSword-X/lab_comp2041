#!/usr/bin/perl -w 

$word = lc $ARGV[0];

foreach $file (glob "lyrics/*.txt") {
   open F, "<", "$file" or die "$0: Can't open $file: $!";
   $count = 0;
   $total = 0;

   while($line = <F>) {
      undef @words;

      $line = lc $line;
      @words = split(/[^a-zA-Z]+/, $line);

      foreach $w (@words) {
         if($w) {
            $total++;

            if($w eq $word) {
               $count++;
            }
         }
      }
   }

   $artist = $file;
   $artist =~ s/lyrics\/(.*).txt/$1/;
   $artist =~ s/[^a-zA-Z]/ /g;

   $n_words{$artist} = $total;
   $table{$artist}{$word} = $count;
   close F;
}

foreach $artist (sort keys %table) {
   printf "log((%d+1)/%6d) = %8.4f %s\n", $table{$artist}{$word}, $n_words{$artist}, 
                                          log(($table{$artist}{$word}+1)/$n_words{$artist}), 
                                          $artist;
} 
