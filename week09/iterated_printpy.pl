#!/usr/bin/perl -w

$n = $ARGV[0];
$string = $ARGV[1];

sub python3($) {
   my $ref = $_[0];
   $$ref =~ s/\\/\\\\/g;
   $$ref =~ s/\"/\\\"/g;
   $$ref =~ s/\'/\\\'/g;
   $$ref = "print(\"\"\"$$ref\"\"\")";
}

sub perl($) {
   my $ref = $_[0];
   $$ref =~ s/\\/\\\\/g;
   $$ref =~ s/\"/\\\"/g;
   $$ref =~ s/\'/\\\'/g;
   $$ref = "print \"$$ref\\n\"";
}


python3(\$string);

$i = 0;
while ($i < $n) {
   perl(\$string);
   python3(\$string);
   $i++;
}

print "$string\n";
