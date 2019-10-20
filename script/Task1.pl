#!C:\strawberry\perl\bin\perl.exe
# The traditional first program.
 
# Strict and warnings are recommended.
use strict;
use warnings;

my $random_number = rand();

my @probabilities = (0.2, 0.1, 0.4, 0.3);
my @numbers = (144, 9001, 24, 20);

my $eps = 0.0001;
my $sum_probs = 0;
foreach my $i (0 .. $#probabilities) {
    $sum_probs += $probabilities[$i];
}

if ($#probabilities != $#numbers) {
    print "Error: probabilities and numbers amount is not equal \n";
}
elsif ($sum_probs < 1 - $eps || $sum_probs > 1 + $eps) {
    print "Error: sum of probabilities is not 1\n";
}
else {
    my $consequitive_sum = 0;
    foreach my $i (0 .. $#probabilities) {
        print "$numbers[$i]: $probabilities[$i]\n";
        $consequitive_sum += $probabilities[$i];
        if ($random_number + $eps < $consequitive_sum) {
            print "Number from uneven distrubtion: $numbers[$i]\n";
            last;
        }
    }
}


# Print a message.
print $random_number, "\n";