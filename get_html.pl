#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;
use Encode;
use utf8;
binmode(STDIN, ':encoding(utf8)');
binmode(STDOUT, ':encoding(utf8)');
binmode(STDERR, ':encoding(utf8)');

if (@ARGV != 2) {
	print "\n\tFunction: extract html content from http site\n\n";
	print "\t\tUsage: <url_> <out>\n\n";
	exit;
}

my ($ini_url,$out) = @ARGV;

my $content = get ("$ini_url");
open OUT,">$out" || die $!;
print OUT "$content\n";
close OUT;
