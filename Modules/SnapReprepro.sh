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
