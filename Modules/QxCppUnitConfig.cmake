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
# - Try to find LibQxCppUnit (libqxcppunit)
#
# Once done this will define
#
# LIBQXCPPUNIT_FOUND        - System has LibQxCppUnit
# LIBQXCPPUNIT_INCLUDE_DIRS - The LibQxCppUnit include directories
# LIBQXCPPUNIT_LIBRARIES    - The libraries needed to use LibQxCppUnit (none)
# LIBQXCPPUNIT_DEFINITIONS  - Compiler switches required for using LibQxCppUnit (none)

find_path( LIBQXCPPUNIT_INCLUDE_DIR testrunner.h
        PATHS $ENV{LIBQXCPPUNIT_INCLUDE_DIR}
        PATH_SUFFIXES qxcppunit
    )
find_library( LIBQXCPPUNIT_LIBRARY qxcppunitd
        PATHS $ENV{LIBQXCPPUNIT_LIBRARY}
    )
mark_as_advanced( LIBQXCPPUNIT_INCLUDE_DIR LIBQXCPPUNIT_LIBRARY )

set( LIBQXCPPUNIT_INCLUDE_DIRS ${LIBQXCPPUNIT_INCLUDE_DIR} )
set( LIBQXCPPUNIT_LIBRARIES    ${LIBQXCPPUNIT_LIBRARY} )

include( FindPackageHandleStandardArgs )
# handle the QUIETLY and REQUIRED arguments and set LIBQXCPPUNIT_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args( LibQXCPPUNIT DEFAULT_MSG LIBQXCPPUNIT_INCLUDE_DIR LIBQXCPPUNIT_LIBRARY )

# vim: ts=4 sw=4 et
