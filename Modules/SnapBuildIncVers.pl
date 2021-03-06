#!/usr/bin/perl -w

################################################################################
# SnapBuildIncVers.pl
# Author: R. Douglas Barbieri
#
# This perl script goes through the entire tree of projects, finds all of the
# Debianized projects (should be all of them) then adds a new changelog record
# with an incremented build number.
#
################################################################################
#
# Copyright (c) 2011-2021  Made to Order Software Corp.  All Rights Reserved
#
# http://snapwebsites.org/
# contact@m2osw.com
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
################################################################################
#
die "usage: SnapBuildIncVers.pl <cache filename> <dist>\n" unless $#ARGV == 1;

use strict;
use Cwd;
use Dpkg::Changelog::Parse;
use Dpkg::Control::Info;
use Dpkg::Deps;
use Storable;

my $cache_file   = shift;
my $distribution = shift;
my $change_msg   = "Nightly build.";

my %options;

if( not $ENV{"DEBEMAIL"} )
{
    $ENV{"DEBEMAIL"} = "Build Server <build\@m2osw.com>";
}

################################################################################
# Search our folder for all debian projects.
#
die unless stat( $cache_file );

my $hashref = retrieve( $cache_file );
my %DIRHASH = %$hashref;


################################################################################
# Next, go through all of the projects and bump the versions.
#
for my $project (keys %DIRHASH)
{
    my $projectdir = $DIRHASH{$project};
    chdir( $projectdir );

    # Get name and version from changelog
    #
    my @fields = changelog_parse(%options);
    my $name;
    my $dist;
    my $urgency;
    my $version;
    my $changes;
    foreach my $f (@fields)
    {
        $name    = $f->{"Source"}       if exists $f->{"Source"};
        $dist    = $f->{"Distribution"} if exists $f->{"Distribution"};
        $version = $f->{"Version"}      if exists $f->{"Version"};
        $urgency = $f->{"Urgency"}      if exists $f->{"Urgency"};
        $changes = $f->{"Changes"}      if exists $f->{"Changes"};
    }

    # Increment the version
    #
    $version =~ s/~.*$//;
    my $newvers;
    if( $version =~ m/^(\d*).(\d+).(\d+)$/ )
    {
        $newvers = "$1.$2.$3.1";
    }
    elsif( $version =~ m/^(\d*).(\d+).(\d+)-(\d+)$/ )
    {
        $newvers = "$1.$2.$3.1-$4";
    }
    elsif( $version =~ m/^(\d*).(\d+).(\d+).(\d+)$/ )
    {
        my $num = $4+1;
        $newvers = "$1.$2.$3.$num";
    }
    elsif( $version =~ m/^(\d*).(\d+).(\d+).(\d+)-(\d+)$/ )
    {
        my $num = $4+1;
        $newvers = "$1.$2.$3.$num-$5";
    }

    my @lines = split /\n/, $changes;
    my $prepend_newchange = 1;
    for my $line (@lines)
    {
        if( $line =~ m/^  \* $change_msg/ )
        {
            $prepend_newchange = 0;
            last;
        }
    }

    if( $prepend_newchange == 1 )
    {
        # Write a new changelog entry with the new version
        #
        system "dch --newversion $newvers~$distribution --urgency high --distribution $distribution $change_msg";
    }
    else
    {
        system "sed -i.bak -e 's/$name ($version~$distribution) $dist; urgency=$urgency/$name ($newvers~$distribution) $distribution; urgency=$urgency/' debian/changelog";
    }
}

# vim: ts=4 sw=4 et
