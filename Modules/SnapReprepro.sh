#!/bin/bash
#
# This script runs the "reprepro" binary against the pbuidler dir.
# `*.changes` files are expected to exist. You must pass in a component
# name (e.g. contrib, non-free, main, etc.).
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
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
    echo "usage: $0 distribution component destpath"
    exit 1
fi

DIST=$1
COMP=$2
DEST=$3

reprepro -C ${COMP} -Vb ${DEST} removematched ${DIST} "*"

INDIR=${HOME}/pbuilder/${DIST}_result/${COMP}
for file in ${INDIR}/*.deb
do
    reprepro -C ${COMP} -Vb ${DEST} includedeb ${DIST} ${file}
done

# vim: ts=4 sw=4 et
