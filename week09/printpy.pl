#!/usr/bin/perl -w

$string = $ARGV[0];

print "#!/usr/bin/python3\n";
print "\n";
print "import sys\n";
print "\n";
$string =~ s/\\/\\\\/g;
$string =~ s/\"/\\\"/g;
$string =~ s/\'/\\\'/g;
print "print(\"\"\"$string\"\"\")\n";

