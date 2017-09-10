#!/usr/bin/perl -w

sub removeTag($) {
   my $line = $_[0];

   while ($line =~ /\<|\>/) {
      $line =~ s/<[^>]*>//;
   }

   return $line;
}

sub trim($) {
   my $line = $_[0];

   $line =~ s/^\s+//;
   $line =~ s/\s+$//;
   return $line;
}

# ------------------------------------------------------------------------------

foreach $course (@ARGV) {
   next if defined $course_list{$course};

   open F, "-|", "wget -q -O- http://timetable.unsw.edu.au/current/$course.html";
   
   while ($line = <F>) {
      $line = removeTag($line);
   
      if ($line =~ /^\s+Lecture/) {
         undef @lines;
   
         for (0..4) {
            $line = <F>;
            $line = removeTag($line);
            $line = trim($line);
            push @lines, $line;
         }

         while ($line = <F>) {
            $line = removeTag($line);
            $line = trim($line);
  
            if ($line) {
               if (defined $lines[5]) {
                  $lines[5] .= " $line";
               } else {
                  $lines[5] = $line;
               }
            } else {
               last;
            }
         }

         if (defined $lines[5]) {
            if($lines[0] eq "T1") {
               $lines[0] = "S1"; 
            } elsif ($lines[0] eq "T2") {
               $lines[0] = "S2";
            } elsif ($lines[0] eq "U1") {
               $lines[0] = "X1";
            }

            next if defined $timetable{$course}{$lines[0]}{$lines[5]};

            $course_list{$course} = 1;
            $timetable{$course}{$lines[0]}{$lines[5]} = 1;
            print "$course: $lines[0] $lines[5]\n";
         }
      }
   }
   
   close F;
}
