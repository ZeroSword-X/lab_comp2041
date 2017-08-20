#!/usr/bin/perl -w

@array = ();
while ($line = <STDIN>) {
   chomp $line;
   push @array, $line;
}

$i = 0;
$n = @array;

for($i = 0; $i < $n; $i++) {
   $p = int(rand($n));
   $q = int(rand($n));

   if ($p != $q) {
      $tmp = $array[$p];
      $array[$p] = $array[$q];
      $array[$q] = $tmp;
   }
}

foreach $i (@array) {
   print "$i\n";
}
