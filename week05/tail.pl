#!/usr/bin/perl -w

$argc = $#ARGV + 1;

if ($argc == 0) {
   $i = 0;
   while($line = <STDIN>) {
      chomp $line;
      $array[$i] = $line;
      $i++;
   }
 
   if($i > 10) {
      $i = -10;
   } else {
      $i = -$i;
   }

   while($i <= -1) {
      print "$array[$i]\n";
      $i++;
   }

   exit 0;
 
} else {
   foreach $arg (@ARGV) {
      if ($arg eq "--version") {
         print "$0: version 0.1\n";
         exit 0;
      } elsif ($arg =~ /^-\d+$/) {
         $numLines = -$arg;
      } else {
         push @files, $arg;
      }
   }

   foreach $f (@files) {
      open F, '<', $f or die "$0: Can't open $f: $!\n";

      $i = 0;
      undef @array;
      while ($line = <F>) {
         chomp $line;
         $array[$i] = $line;
         $i++;
      }
      close F;

      if(defined $numLines) {
         if ($i > $numLines) {
            $i = -$numLines;
         } else {
            $i = -$i;
         }
      } else {
         if ($i > 10) {
            $i = -10;
         } else {
            $i = -$i;
         }
      }

      if(@files > 1) {
         print "==> $f <==\n";
      }

      while($i <= -1) {
         print "$array[$i]\n";
         $i++;
      }
   }

}


