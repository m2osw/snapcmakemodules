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
