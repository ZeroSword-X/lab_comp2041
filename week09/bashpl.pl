#!/usr/bin/perl -w

while ($line = <>) {
   if ($. == 1 && $line =~ /^#!/) {
      $line = "#!/usr/bin/perl -w\n";
   }

   push @code, $line;
}

foreach $line (@code) {
   if ($line =~ /^[\s\t]*#/) {
      print "$line";
   } elsif ($line =~ /^[\s\t]*$/) {
      print "$line";
   } else {
      if ($line =~ /^([\s\t]*)(\w+)=(.+)/) {
         $indent = $1;
         $var = $2;
         $variable{$var} = 1;
         $value = $3;
          
         if ($value =~ /\$\(\((.*)\)\)/) {
            $exp = $1;
            @objects = split(/[\s\t]+/, $exp);

            foreach $o (@objects) {
               if ($variable{$o}) {
                  $o = "\$$o";
               }
            }
            $value = join(" ", @objects); 
         }

         print "$indent","\$$var = $value;\n";
      } elsif ($line =~ /^[\s\t]*echo/) {
         ($indent, $string) = ($line =~ /^([\s\t]*)echo[\s\t]*(.*)$/);
         print "$indent", "print \"$string", "\\n\"", ";\n";
      } elsif ($line =~ /^[\s\t]*(do|then)[\s\t]*$/) {

      } elsif ($line =~ /^([\s\t]*)(done|fi)[\s\t]*/) {
         $indent = $1;
         print "$indent}\n";
      } elsif ($line =~ /^([\s\t]*)while/) {
         ($indent, $condition) = ($line =~ /^([\s\t]*)while[\s\t]*\(\((.*)\)\)/);
         @objects = split(/[\s\t]+/, $condition);

         foreach $o (@objects) {
            if ($variable{$o}) {
               $o = "\$$o";
            }
         }
         $condition = join(" ", @objects);
         print "$indent", "while (", "$condition", ") {\n";
      } elsif ($line =~ /^([\s\t]*)if[\s\t]*\(\((.*)\)\)/) {
         $indent = $1;
         $condition = $2;
         @objects = split(/[\s\t]+/, $condition);

         foreach $o (@objects) {
            if ($variable{$o}) {
               $o = "\$$o";
            }
         }
         $condition = join(" ", @objects);
         print "$indent", "if (", "$condition", ") {\n";
      } elsif ($line =~ /([\s\t]*)else[\s\t]*$/) {
         print "$1","} else {\n";
      }
   } 
}

