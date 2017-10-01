#!/usr/bin/perl -w

$num_dl = 0;
$num_lines = 0;

while ($line = <STDIN>) {
   chomp $line;
   $num_lines++;

   $line = lc $line;
   $line =~ s/\s//g;

   if (!defined $lines{$line}) {
      $lines{$line} = 1;
      $num_dl++;

      if ($num_dl == $ARGV[0]) {
         print "$num_dl distinct lines seen after $num_lines lines read.\n";
         exit 0;
      }
   }
}

print "End of input reached after $num_lines lines read - $ARGV[0] different lines not seen.\n";
