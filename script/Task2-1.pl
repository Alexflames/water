#!C:\strawberry\perl\bin\perl.exe
# The traditional first program.
 
# Strict and warnings are recommended.
use strict;
use warnings;

use MP3::Tag;

my $mp3 = MP3::Tag->new("Carpenter Brut-What We Fight For -Furi OST.mp3");
$mp3->get_tags(); #read tags
if (exists $mp3->{ID3v1}) {
    print 'Title:   ', $mp3->{ID3v1}->title. "\n";
    print 'Year:    ', $mp3->{ID3v1}->year. "\n";
    print 'Album:    ', $mp3->{ID3v1}->album. "\n";    
    print 'Artist:    ', $mp3->{ID3v1}->artist. "\n";
    print 'Album track number:    ', $mp3->{ID3v1}->track. "\n";
    print 'Comment:     ', $mp3->{ID3v1}->comment. "\n";
}
