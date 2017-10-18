#!/usr/bin/perl -w

@lines = ();

open F, "<", $ARGV[0] or die "$0: $!\n";
while ($line = <F>) {
   chomp $line;
   $line =~ s/[aeiouAEIOU]//g;
   push @lines, $line;
}
close F;

open F, ">", $ARGV[0] or die "$0: $!\n";
for $line (@lines) {
   print F "$line\n";
}
close F;
