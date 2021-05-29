################################################################################
#
# Copyright (c) 2011-2021  Made to Order Software Corp.  All Rights Reserved
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
# - Try to find LibQxRunner (libqxrunner)
#
# Once done this will define
#
# LIBQXRUNNER_FOUND        - System has LibQxCppUnit
# LIBQXRUNNER_INCLUDE_DIRS - The LibQxCppUnit include directories
# LIBQXRUNNER_LIBRARIES    - The libraries needed to use LibQxCppUnit (none)
# LIBQXRUNNER_DEFINITIONS  - Compiler switches required for using LibQxCppUnit (none)

find_path( LIBQXRUNNER_INCLUDE_DIR runner.h
        PATHS $ENV{LIBQXRUNNER_INCLUDE_DIR}
        PATH_SUFFIXES qxrunner
    )
find_library( LIBQXRUNNER_LIBRARY qxrunnerd
        PATHS $ENV{LIBQXRUNNER_LIBRARY}
    )
mark_as_advanced( LIBQXRUNNER_INCLUDE_DIR LIBQXRUNNER_LIBRARY )

set( LIBQXRUNNER_INCLUDE_DIRS ${LIBQXRUNNER_INCLUDE_DIR} )
set( LIBQXRUNNER_LIBRARIES    ${LIBQXRUNNER_LIBRARY} )

include( FindPackageHandleStandardArgs )
# handle the QUIETLY and REQUIRED arguments and set LIBQXRUNNER_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args( LibQXRUNNER DEFAULT_MSG LIBQXRUNNER_INCLUDE_DIR LIBQXRUNNER_LIBRARY )

# vim: ts=4 sw=4 et
