#!/usr/bin/perl -w

@lines = ();
while ($line = <STDIN>) {
   push @lines, $line;
}

foreach $line (@lines) {
   chomp $line;
   @words = split(/\s+/, $line);

   foreach $word (@words) {
      undef %counter;
      @characters = split(//, $word);

      foreach $char (@characters) {
         $char = lc $char;
         $counter{$char} += 1; 
      }

      $times = -1;
      $equi = 1;
      foreach $char (keys %counter) {
         if ($times == -1) {
            $times = $counter{$char};
         } else {
            if ($counter{$char} != $times) {
               $equi = 0;
               last;
            }
         }
      }

      print "$word " if ($equi);
   }
 
   print "\n";
}
