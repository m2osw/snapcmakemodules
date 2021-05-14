################################################################################
#
# Copyright (c) 2011-2019  Made to Order Software Corp.  All Rights Reserved
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
# - Try to find LibProcPS (libprocps3)
#
# Once done this will define
#
# LIBPROCPS_FOUND        - System has LibProcPS
# LIBPROCPS_INCLUDE_DIRS - The LibProcPS include directories
# LIBPROCPS_LIBRARIES    - The libraries needed to use LibProcPS (none)
# LIBPROCPS_DEFINITIONS  - Compiler switches required for using LibProcPS (none)

find_path(LIBPROCPS_INCLUDE_DIR readproc.h
    PATHS $ENV{LIBPROCPS_INCLUDE_DIR}
    PATH_SUFFIXES proc
)
find_library(LIBPROCPS_LIBRARY procps
    PATHS $ENV{LIBPROCPS_LIBRARY}
)

mark_as_advanced(LIBPROCPS_INCLUDE_DIR LIBPROCPS_LIBRARY)

set(LIBPROCPS_INCLUDE_DIRS ${LIBPROCPS_INCLUDE_DIR})
set(LIBPROCPS_LIBRARIES    ${LIBPROCPS_LIBRARY})

# handle the QUIETLY and REQUIRED arguments and set LIBPROCPS_FOUND to TRUE
# if all listed variables are TRUE
#
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    ProcPS
    DEFAULT_MSG
    LIBPROCPS_INCLUDE_DIR
    LIBPROCPS_LIBRARY
)

# vim: ts=4 sw=4 et
