################################################################################
#
# Copyright (c) 2011-2022  Made to Order Software Corp.  All Rights Reserved
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
# Source: https://github.com/phtrivier/cppunit-money-example-cmake/blob/master/code/cmake_modules/FindCPPUNIT.cmake
#
# Find the CppUnit includes and library
#
# This module defines:
#
#  CPPUNIT_INCLUDE_DIR     where to find tiff.h, etc.
#  CPPUNIT_LIBRARIES       the libraries to link against to use CppUnit.
#  CPPUNIT_FOUND           if false, do not try to use CppUnit.
#
# Also defined, but not for general use are:
#
#  CPPUNIT_LIBRARY         where to find the CppUnit library.
#  CPPUNIT_DEBUG_LIBRARY   where to find the CppUnit library in debug mode.
#

SET(CPPUNIT_FOUND "NO")

FIND_PATH(CPPUNIT_INCLUDE_DIR
	cppunit/TestCase.h
	PATHS
		cppunit/include
		/usr/local/include
		/usr/include
)

# With Win32, important to have both
IF(WIN32)
  FIND_LIBRARY(CPPUNIT_LIBRARY cppunit
               ${CPPUNIT_INCLUDE_DIR}/../lib
               /usr/local/lib
               /usr/lib)
  FIND_LIBRARY(CPPUNIT_DEBUG_LIBRARY cppunitd
               ${CPPUNIT_INCLUDE_DIR}/../lib
               /usr/local/lib
               /usr/lib)
ELSE(WIN32)
  # On unix system, debug and release have the same name
  FIND_LIBRARY(CPPUNIT_LIBRARY cppunit
               ${CPPUNIT_INCLUDE_DIR}/../lib
               /usr/local/lib
               /usr/lib
	       /usr/lib/x86_64-linux-gnu)
  FIND_LIBRARY(CPPUNIT_DEBUG_LIBRARY cppunit
               ${CPPUNIT_INCLUDE_DIR}/../lib
               /usr/local/lib
               /usr/lib
	       /usr/lib/x86_64-linux-gnu)
ENDIF(WIN32)

IF(CPPUNIT_INCLUDE_DIR)
  IF(CPPUNIT_LIBRARY)
    SET(CPPUNIT_FOUND "YES")
    SET(CPPUNIT_LIBRARIES ${CPPUNIT_LIBRARY} ${CMAKE_DL_LIBS})
    SET(CPPUNIT_DEBUG_LIBRARIES ${CPPUNIT_DEBUG_LIBRARY} ${CMAKE_DL_LIBS})
  ELSE(CPPUNIT_LIBRARY)
    IF(CPPUNIT_FIND_REQUIRED)
      MESSAGE(SEND_ERROR "Could not find library CppUnit.")
    ENDIF(CPPUNIT_FIND_REQUIRED)
  ENDIF(CPPUNIT_LIBRARY)
ELSE(CPPUNIT_INCLUDE_DIR)
  IF(CPPUNIT_FIND_REQUIRED)
    MESSAGE(SEND_ERROR "Could not find library CppUnit.")
  ENDIF(CPPUNIT_FIND_REQUIRED)
ENDIF(CPPUNIT_INCLUDE_DIR)
