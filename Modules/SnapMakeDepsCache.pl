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
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
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
