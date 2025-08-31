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
# - Try to find LibQREncode (libqrencode)
#
# Once done this will define
#
# LIBQRENCODE_FOUND        - System has libqrencode.so
# LIBQRENCODE_INCLUDE_DIRS - The qrencode include directories
# LIBQRENCODE_LIBRARIES    - The libraries needed to use qrencode
# LIBQRENCODE_DEFINITIONS  - Compiler switches required for using qrencode (none)

find_path(LIBQRENCODE_INCLUDE_DIR qrencode.h
    PATHS $ENV{LIBQRENCODE_INCLUDE_DIR}
)
find_library(LIBQRENCODE_LIBRARY qrencode
    PATHS $ENV{LIBQRENCODE_LIBRARY}
)

mark_as_advanced(LIBQRENCODE_INCLUDE_DIR LIBQRENCODE_LIBRARY)

set(LIBQRENCODE_INCLUDE_DIRS ${LIBQRENCODE_INCLUDE_DIR})
set(LIBQRENCODE_LIBRARIES    ${LIBQRENCODE_LIBRARY})

# handle the QUIETLY and REQUIRED arguments and set LIBQRENCODE_FOUND to TRUE
# if all listed variables are TRUE
#
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    LibQREncode
    DEFAULT_MSG
    LIBQRENCODE_INCLUDE_DIR
    LIBQRENCODE_LIBRARY
)

# vim: ts=4 sw=4 et
