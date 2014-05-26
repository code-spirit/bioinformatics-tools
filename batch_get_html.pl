#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;
use Encode;
use utf8;
binmode(STDIN, ':encoding(utf8)');
binmode(STDOUT, ':encoding(utf8)');
binmode(STDERR, ':encoding(utf8)');

if (@ARGV != 3) {
	print "\n\tFunction: extract html content from batch http site\n\n";
	print "\t\tUsage: <url_ini> <suffix_list> <out_dir>\n\n";
	exit;
}

my ($url_ini,$list_file,$od) = @ARGV;

my %suffix;
&suffix_read_ ($list_file,\%suffix);

open LIST,">$od/html_address.list" || die $!;
foreach my $suffix_name (sort keys %suffix) {
	print LIST "$url_ini/$suffix_name\n";

	my $html;
	open OUT,">$od/$suffix_name.txt" || die $!;
	&get_html ("$url_ini/$suffix_name",$html);
	print OUT "$html\n";
	close OUT;
}

#+=====================
#  subs
#+=====================
sub suffix_read_ {
	my ($file,$suffix) = @_;

	open IN,"$file" || die $!;
	while (<IN>) {
		chomp;
		s/\s+$//;
		next if (/^$/ || /^\#/);
		$suffix->{$_}=1;
	}
	close IN;
}

sub get_html_ {
	my ($url,$html) = @_;

	$html = get ("$url");
	return ($html);
}
