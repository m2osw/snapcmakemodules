#!/bin/bash

# This script creates a source package for the project in the current directory.
# In order for this to work properly, there has to be a debian folder present,
# with proper files present.
#
# The parameter to the script is the platform on which to build
# (i.e. saucy, trusty, etc). The default is "xenial" at the moment.
#
################################################################################
#
# Copyright (c) 2011-2018  Made to Order Software Corp.  All Rights Reserved
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

set -e

# Handle command line
#
if [ -z "$1" ]
then
    DIST=xenial
else
    DIST=$1
fi

if [ ! -e debian/changelog ]
then
    echo "No debian changelog found!"
    exit 1
fi

# Use the build server email and name. This will appear in the changelog.
#
if [ -z "${DEBEMAIL}" ]
then
    export DEBEMAIL="Build Server <build@m2osw.com>"
fi

# Clean up the old files
#
NAME=`dpkg-parsechangelog --show-field Source`
VERSION=`dpkg-parsechangelog --show-field Version`
FULLNAME=${NAME}_${VERSION}
echo "Building source package for '${FULLNAME}'"
rm -f ../${FULLNAME}.dsc ../${FULLNAME}_source.* ../${FULLNAME}.tar.gz

# Build the source package itself. The output will be placed in the parent directory
# of the CWD.
#
debuild -S -sa -nc -m"${DEBEMAIL}"

# vim: ts=4 sw=4 et
