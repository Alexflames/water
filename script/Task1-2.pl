#!C:\strawberry\perl\bin\perl.exe
# The traditional first program.
 
# Strict and warnings are recommended.
use strict;
use warnings;

my %hash = (
    "bolt" => 12,
    "supergamer2000" => 20,
    "sadpotato" => 15,
    "ferdinand" => 15
    );

my %registrations = ();
while ( my ($key, $value) = each(%hash) ) {
    $registrations{$value} = 0;
}

my $maxnum = 0;
my $maxvalue = 0;
while ( my ($key, $value) = each(%hash) ) {
    $registrations{$value}++;
    if ($registrations{$value} > $maxnum) {
        $maxnum = $registrations{$value};
        $maxvalue = $value;
    }
}

# Print a message.
print "The most common number of registrations: $maxvalue", "\n";