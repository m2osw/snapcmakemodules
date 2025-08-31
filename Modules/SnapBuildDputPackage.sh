#!/bin/bash
#
# This script uploads a source package to the lp servers, using "ppa:snapcpp/ppa".
#
# The parameter to the script is the package name which will be built. It is assumed that
# the debian subfolder is one level down, in the folder name provided. Package will
# be determined using dpkg-parsechangelog.
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

# Handle command line
#
#if [ -z "$1" ]
#then
#    echo "usage: $0 package-dir"
#    exit 1
#fi
#
#PKGDIR=$1
#if [ ! -e "${PKGDIR}" ]
#then
#    echo "Directory '${PKGDIR}' does not exist!"
#    exit 1
#fi
#cd ${PKGDIR}

set -e

if [ ! -e debian/changelog ]
then
    echo "No debian changelog found!"
    exit 1
fi

NAME=`dpkg-parsechangelog --show-field Source`
VERSION=`dpkg-parsechangelog --show-field Version`

if test ! -f ../${NAME}_${VERSION}_source.changes
then
    # Remove old versions otherwise they pile up and it becomes
    # a really long list difficult to manage
    #
    rm -f ../${NAME}_*.dsc ../${NAME}_*_source.* ../${NAME}_*.tar.gz

    debuild -S -sa
    dput ppa:snapcpp/ppa ../${NAME}_${VERSION}_source.changes
else
    echo "warning: debuild and dput not run because the source files already exists,"
    echo "         you must change the version and try again."
fi

exit 0

# vim: ts=4 sw=4 et
