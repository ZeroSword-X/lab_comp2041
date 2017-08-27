#!/usr/bin/perl -w

while($line = <STDIN>) {
   chomp $line;
   $line = lc $line;
   $line =~ s/[ ]{2,}/ /g;
   $line =~ s/[sS]$//g;
   $line =~ s/[ ]$//g;
   $line =~ /(\d+) (.+)/;

   $num = $1;
   $name = $2;

   $pods{$name}++;
   $count{$name} += $num;
}

foreach $name (sort keys %pods) {
   print "$name observations: $pods{$name} pods, $count{$name} individuals\n";
}
