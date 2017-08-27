#!/usr/bin/perl -w

sub non_recursive {
   $url = "http://www.handbook.unsw.edu.au/undergraduate/courses/current/$ARGV[0].html";
   open F, "wget -q -O- $url | egrep -o '<p>Prerequisite[s]?[^<]+' | sed -e 's/Corequisite[s]\\?:.\\+//g' -e 's/Exclusion[s]\\?:.\\+//g' | egrep -o '[A-Z]{4}[0-9]{4}' |" or die;
   while ($line = <F>) {
      chomp $line;
      push @array, $line;
   }
   
   $url = "http://www.handbook.unsw.edu.au/postgraduate/courses/current/$ARGV[0].html";
   open F, "wget -q -O- $url | egrep -o '<p>Prerequisite[s]?[^<]+</p><p>' | sed -e 's/Corequisite[s]\\?:.\\+//g' -e 's/Exclusion[s]\\?:.\\+//g' | egrep -o '[A-Z]{4}[0-9]{4}' |" or die;
   while ($line = <F>) {
      chomp $line;
      push @array, $line;
   }
   
   foreach $i (sort @array) {
      print "$i\n";
   }
}

sub recursive {
   chomp $_[0];
   my $arg = $_[0];

   my $url = "http://www.handbook.unsw.edu.au/undergraduate/courses/current/$arg.html";
   open my $F, "wget -q -O- $url | egrep -o '<p>Prerequisite[s]?[^<]+</p><p>' | sed -e 's/Corequisite[s]\\?:.\\+//g' -e 's/Exclusion[s]\\?:.\\+//g' | egrep -o '[A-Z]{4}[0-9]{4}' |" or die;
   while($line = <$F>) {
      chomp $line;
      if(!defined $courses{$line}) {
         $courses{$line} = $line;
         recursive($line);      
      } 
   }

   $url = "http://www.handbook.unsw.edu.au/postgraduate/courses/current/$arg.html";
   open $F, "wget -q -O- $url | egrep -o '<p>Prerequisite[s]?[^<]+</p><p>' | sed -e 's/Corequisite[s]\\?:.\\+//g' -e 's/Exclusion[s]\\?:.\\+//g' | egrep -o '[A-Z]{4}[0-9]{4}' |" or die; 
   while($line = <$F>) {
      chomp $line;
      if(!defined $courses{$line}) {
         $courses{$line} = $line;
         recursive($line);      
      }
   }
}



if($ARGV[0] eq "-r") {
   recursive($ARGV[1]);

   foreach $i (sort keys %courses) {
      print "$i\n";
   }
} else {
   non_recursive();
}
