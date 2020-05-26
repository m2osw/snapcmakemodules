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
# Copyright (c) 2011-2019  Made to Order Software Corp.  All Rights Reserved
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
die "usage: SnapMakeDepsCache.pl [root source directory] [cache filename]\n" unless $#ARGV == 1;

use File::Find;
use Storable;

my $dir         = shift;
my $cache_file  = shift;

my %DIRHASH;

sub projects_wanted
{
    if( not stat($File::Find::name . "/debian/control") )
    {
        return;
    }
    if( index($File::Find::name, "/archive/") != -1
    ||  index($File::Find::name, "/tmp/") != -1 )
    {
        return;
    }

    $DIRHASH{$_} = $File::Find::name;
}

find( {wanted => \&projects_wanted, no_chdir => 0}, $dir );
store \%DIRHASH, $cache_file;

# vim: ts=4 sw=4 et
