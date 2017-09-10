#!/usr/bin/perl -w

$url = "http://www.timetable.unsw.edu.au/current/$ARGV[0]KENS.html";
open F, "-|", "wget -q -O- $url";

while ($line = <F>) {
   ($course) = ($line =~ /($ARGV[0]\d{4})/);
   
   if ($course && !defined $list{$course}) {
      $list{$course} = 1;
   }   
}

close F;

foreach $course (sort keys %list) {
   print "$course\n";
}
