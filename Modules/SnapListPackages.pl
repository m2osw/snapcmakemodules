#!/usr/bin/perl -w

################################################################################
# SnapListPackages.pl
# Author: Alexis Wilke
#
# This perl script opens a project's debian control file and lists the name
# of each of the packages and their architecture.
#
# This is currently used by the snapbuilder tool.
#
################################################################################
#
# Copyright (c) 2023-2025  Made to Order Software Corp.  All Rights Reserved
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
die "usage: SnapListPackages.pl [debian dir]\n" unless $#ARGV == 0;

use Cwd;
use Dpkg::Control::Info;

my $debian_dir  = shift;

chdir($debian_dir);

# Load control file and list Package: ... names
#
my $dep_ctl = Dpkg::Control::Info->new();
my @control_pkgs = $dep_ctl->get_packages();
foreach my $p (@control_pkgs)
{
    my $pkg = $p->{"Package"};
    my $arch = $p->{"Architecture"};
    print "$pkg $arch\n";
}

# vim: ts=4 sw=4 et
