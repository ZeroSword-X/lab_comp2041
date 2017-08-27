#!/usr/bin/perl -w

$pods = 0;
$sum = 0;
$species = $ARGV[0];
while($line = <STDIN>) {
   $line =~ /([0-9]+) (.+)/;
   $num = $1;
   $name = $2;

   if($name eq $species) {
      $pods++;
      $sum += $num;
   }
}

print "$ARGV[0] observations: $pods pods, $sum individuals\n"
