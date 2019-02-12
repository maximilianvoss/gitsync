#!/usr/bin/perl
#
# Comments are marked with a Hash (#)
# 
# Config Syntax: 
# [id which is used for directory]: [src repo] -> [dest repo]
#
# Example:
# BeatTheWeight: git@git.voss.rocks:apps/BeatTheWeight.git -> git@github.com:maximilianvoss/BeatTheWeight.git

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

		my $cmd = "cd $id; git fetch --all; git branch -a";
		print 'Finding all remote branches: ' . $cmd . "\n";
		my @result = `$cmd`;

		for ( my $i; $i < @result; $i++ ) {
			if ( $result[$i] =~ /^\s*remotes\/origin\/(.+)/ && $result[$i] !~ /->/ ) {
				my $branch = $1;

				my $cmd = "(cd $id; git checkout $branch; git pull --all; git push dest --all; git push dest --tags)";
				print 'Syncing the repositories: ' . $cmd . "\n";
				print `$cmd`;
			}
		}
	}
}
close (CONFIG);
