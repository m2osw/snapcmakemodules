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

# Remove all versions otherwise they pile up and it becomes a really long list
#
rm -f ../${NAME}_*.dsc ../${NAME}_*_source.* ../${NAME}_*.tar.gz

# Build the source package itself. The output will be placed in the parent directory
# of the CWD.
#
echo "Building source package for '${FULLNAME}'"
debuild -S -sa -nc -m"${DEBEMAIL}"

# vim: ts=4 sw=4 et
