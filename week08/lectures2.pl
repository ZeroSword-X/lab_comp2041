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

if ($ARGV[0] eq "-d" || $ARGV[0] eq "-t") {
   $flag = shift @ARGV;
} else {
   $flag = '';
}

foreach $course (@ARGV) {
   next if defined $course_list{$course};
   $course_list{$course} = 1;

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
            } elsif ($lines[0] =~ /^U1/) {
               $lines[0] =~ s/^U/X/;
            }

            if ($flag) {
               @lecture_time = split(/,\s/, $lines[5]);

               foreach $time (@lecture_time) {
                  ($day) = ($time =~ /(\w+)/);
                  ($start, $end) = ($time =~ /(\d{2})\:\d{2}/g);

                  while ($start < $end) {
                     if (!defined $timetable{$lines[0]}{$course}{$day}{$start}) {
                        $timetable{$lines[0]}{$course}{$day}{$start} = 1;
                        printf "%s %s %s %d\n", "$lines[0]", "$course", "$day", "$start" if ($flag eq "-d");
                     }
                     $start++;
                  }
               }
            } else {
               next if defined $timetable{$course}{$lines[0]}{$lines[5]};
               $timetable{$course}{$lines[0]}{$lines[5]} = 1;
               print "$course: $lines[0] $lines[5]\n";
            }
         }
      }
   }
   
   close F;
}


if ($flag eq "-t") {
   @days = ("Mon", "Tue", "Wed", "Thu", "Fri");

   foreach $semester (sort keys %timetable) {
      printf "%-3s   ", "$semester";

      foreach $day (@days) {
         printf "   $day";
      }
      printf "\n";


      foreach $time (9..20) {
         if($time == 9) {
            $time = "09";
         }
         printf "$time\:00";

         $s = "";
         foreach $day (@days) {
            $total = 0;

            foreach $course (keys %{$timetable{$semester}}) {
               if (defined $timetable{$semester}{$course}{$day}{$time}) {
                  $total++;
               }
            }
 
            if ($total > 0) {
               $s .= "     $total";
            } else {
               $s .= "      ";
            }
         }
         printf "%s\n", "$s";   
      }
   }
}
