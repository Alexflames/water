#!C:\strawberry\perl\bin\perl.exe
# The traditional first program.
 
# Strict and warnings are recommended.
use strict;
use warnings;

my $str = "hf1999t41 237h871h8 7eff1687 3hfe7q w7ee87 f11f18";
my @str_symbols = $str =~ /(\d+)/g;

my $min_number = $str_symbols[0];

foreach my $i (0 .. $#str_symbols) {
    print "Number $i: $str_symbols[$i]\n";
    if ($str_symbols[$i] < $min_number) {
        $min_number = $str_symbols[$i];
    }
}

print "Minimum number: $min_number";

