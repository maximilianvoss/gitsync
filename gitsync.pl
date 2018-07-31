#!/usr/bin/perl
#
# Comments are marked with a Hash (#)
# 
# Config Syntax: 
# [id which is used for directory]: [src repo] -> [dest repo]
#
# Example:
# gitsync: git@git.voss.rocks:Utilities/gitsync.git -> git@github.com:maximilianvoss/gitsync.git

use strict;

open ( CONFIG, 'gitsync.config');
while ( my $line = <CONFIG> ) {
	unless ( $line =~ /^\s*#/ || $line =~ /^\s*$/ ) {
		$line =~ /\s*(\w+):\s*(.+)\s*-\>\s*(.+)\s*$/;
		my $id = $1;
		my $src = $2;
		my $dest = $3;

		print "Syncing: $id\n";

		unless ( -e $id ) {
			my $cmd = "git clone $src $id";
			print 'Initial clone of git repository: ' . $cmd . "\n";
			print `$cmd`;

			my $cmd = "(cd $id; git remote add dest $dest)";
			print 'Setting the destination remote: ' . $cmd . "\n";
			print `$cmd`;
		}

		my $cmd = "(cd $id; git fetch --all; git push dest --all)";
		print 'Syncing the repositories: ' . $cmd . "\n";
		print `$cmd`;
	}
}
close (CONFIG);
