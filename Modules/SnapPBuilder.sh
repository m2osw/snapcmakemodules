#!/bin/bash
#
# This script uploads a source package to the lp servers, using
# "ppa:snapcpp/ppa".
#
# The parameter to the script is the package name which will be built.
# It is assumed that the debian subfolder is one level down, in the
# folder name provided. Package will be determined using
# dpkg-parsechangelog.
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

# Handle command line
#
set -e
if [ -z "$1" ] && [ -z "$2" ]
then
    echo "usage: $0 distribution component [makeflags]"
    exit 1
fi

DIST=$1
COMP=$2
MFLAGS=$3

if [ -n "${MFLAGS}" ]
then
    # The MFLAGS do not make it through the chroot, but I keep this
    # as a reminder
    #
    #export MAKEFLAGS=${MFLAGS}

    # Extract the -j<count> option if any and pass it through the
    # DEB_BUILD_OPTIONS parameter (Note: this can also be done through
    # the .pbuilderrc file)
    #
    case "${MFLAGS}" in
    *-j[0-9]*)
        count=`echo "${MFLAGS}" | sed -e 's/.*-j\([[:digit:]]\)\+.*/\1/'`
        export DEB_BUILD_OPTIONS="parallel=$count"
        ;;
    esac
fi

if [ ! -e debian/changelog ]
then
    echo "No debian changelog found!"
    exit 1
fi

NAME=`dpkg-parsechangelog --show-field Source`
VERSION=`dpkg-parsechangelog --show-field Version`
OUTDIR=${HOME}/pbuilder/${DIST}_result/${COMP}
PARGS="${DIST} build ../${NAME}_${VERSION}.dsc --buildresult ${OUTDIR}"

mkdir -p ${OUTDIR}

if ! pbuilder-dist ${PARGS}
then
    # once in a while we get an error, try again immediately because in
    # most cases the second attempt is more than likely to succeed just
    # fine; i.e. if we get an error such as:
    # https://bugs.launchpad.net/pbuilderjenkins/+bug/1233775
    # if the problem is with the source, it will just fail again...
    pbuilder-dist ${PARGS}
fi

# vim: ts=4 sw=4 et
