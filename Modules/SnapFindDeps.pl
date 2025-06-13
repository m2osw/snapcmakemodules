#!/usr/bin/perl -w

################################################################################
# SnapFindDeps.pl
# Author: R. Douglas Barbieri
#
# This perl script opens a project's debian control file and finds all build
# dependencies. It then iterates through the source directory, finding all
# Debianized projects. It then emits a list of dependencies for the build
# that are found within the archive.
#
################################################################################
#
# Copyright (c) 2011-2025  Made to Order Software Corp.  All Rights Reserved
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
die "usage: SnapFindDeps.pl [cache filename] [project]\n" unless $#ARGV == 1;

use Cwd;
use Dpkg::Changelog::Parse;
use Dpkg::Control::Info;
use Dpkg::Deps;
use Storable;

my $cache_file  = shift;
my $project     = shift;

my %DEPHASH;
my %options;


################################################################################
# First, find every debian project within the specified tree.
#
die unless stat( $cache_file );

my $hashref = retrieve( $cache_file );
my %DIRHASH = %$hashref;

################################################################################
# Next, read all of the dependencies in the specified project.
#
my %dep_list;
my $projectdir = $DIRHASH{$project};
chdir( $projectdir );
#
my $control       = Dpkg::Control::Info->new();
my $fields        = $control->get_source();
my $build_depends = deps_parse($fields->{'Build-Depends'});
#
for my $dep ( $build_depends->get_deps() )
{
    $dep =~ s/([^ ]+) [^\$]+/$1/;
    $dep_list{$dep} = 1;
}


################################################################################
# Next, go through all of the projects and find a match
#
for my $proj (keys %DIRHASH)
{
    if( $proj eq $project )
    {
        # Don't bother scanning this project, because it's the one we're
        # analysing...
        next;
    }

    my $projdir = $DIRHASH{$proj};
    chdir( $projdir );

    my $dep_ctl = Dpkg::Control::Info->new();
    my @control_pkgs = $dep_ctl->get_packages();
    foreach my $p (@control_pkgs)
    {
        my $pkg = $p->{"Package"};
        if( $dep_list{$pkg} )
        {
            print "$proj ";
            last; # We're done, so skip checking the other dependencies in the package
        }
    }
}


# vim: ts=4 sw=4 et
