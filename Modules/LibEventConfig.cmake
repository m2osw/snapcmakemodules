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
# - Try to find libevent2
#
# Once done this will define
#
# LIBEVENT2_FOUND        - System has libevent2
# LIBEVENT2_INCLUDE_DIRS - The libevent2 include directories
# LIBEVENT2_LIBRARIES    - The libraries needed to use libevent2
# LIBEVENT2_DEFINITIONS  - Compiler switches required for using libevent2

find_path( LIBEVENT2_INCLUDE_DIR event2/event.h
			PATHS $ENV{LIBEVENT2_INCLUDE_DIR}
			PATH_SUFFIXES event2
		 )
find_library( LIBEVENT2_LIBRARY event
			PATHS $ENV{LIBEVENT2_LIBRARY}
		 )
mark_as_advanced( LIBEVENT2_INCLUDE_DIR LIBEVENT2_LIBRARY )

set( LIBEVENT2_INCLUDE_DIRS ${LIBEVENT2_INCLUDE_DIR} )
set( LIBEVENT2_LIBRARIES    ${LIBEVENT2_LIBRARY}     )

include( FindPackageHandleStandardArgs )
# handle the QUIETLY and REQUIRED arguments and set LIBEVENT_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args( LibEVENT DEFAULT_MSG LIBEVENT2_INCLUDE_DIR LIBEVENT2_LIBRARY )
