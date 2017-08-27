#!/usr/bin/perl -w

$url = "http://www.handbook.unsw.edu.au/undergraduate/courses/current/$ARGV[0].html";
open F, "wget -q -O- $url | egrep -o '<p>Prerequisite[s]?[^<]+' | sed -e 's/Corequisite[s]\\?:.\\+//g' -e 's/Exclusion[s]\\?:.\\+//g' | egrep -o '[A-Z]{4}[0-9]{4}' | " or die;

while ($line = <F>) {
   chomp $line;
   push @array, $line;
}

$url = "http://www.handbook.unsw.edu.au/postgraduate/courses/current/$ARGV[0].html";
open F, "wget -q -O- $url | egrep -o '<p>Prerequisite[s]?[^<]+</p><p>' | sed -e 's/Corequisite[s]\\?:.\\+//g' -e 's/Exclusion[s]\\?:.\\+//g' | egrep -o '[A-Z]{4}[0-9]{4}' | " or die;
while ($line = <F>) {
   chomp $line;
   push @array, $line;
}

foreach $i (sort @array) {
   print "$i\n";
}

