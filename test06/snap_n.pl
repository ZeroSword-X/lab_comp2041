#!/usr/bin/perl -w

$n = $ARGV[0];

while($line = <STDIN>) {
   if(! defined($lines{$line})) {
      $lines{$line} = 1;
   } else {
      $lines{$line}++;

      if($lines{$line} == $n) {
         print "Snap: ", $line;
         exit 0;
      }
   }  
}
