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
# Copyright (c) 2023  Made to Order Software Corp.  All Rights Reserved
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
