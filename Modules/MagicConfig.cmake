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
# - Try to find the magic library and headers
#
# The magic library is used to check the type of a file from its contents.
#
# Once done this will define
#
# MAGIC_FOUND        - System has Magick
# MAGIC_INCLUDE_DIRS - The magick include directories
# MAGIC_LIBRARIES    - The libraries needed to use magick
# MAGIC_DEFINITIONS  - Compiler switches required for using magick

find_file( MAGIC magic.h )
if( ${MAGIC} STREQUAL "MAGIC-NOTFOUND" )
    message( FATAL_ERROR "Please install libmagic-dev!" )
endif()
get_filename_component( MAGIC_INCLUDE_PATH ${MAGIC} PATH )

find_library( MAGIC_LIBRARY magic )
if( ${MAGIC_LIBRARY} STREQUAL "MAGIC_LIBRARY-NOTFOUND" )
    message( FATAL_ERROR "Please install libmagic-dev!" )
endif()



find_path( MAGIC_INCLUDE_DIR magic.h
        PATHS $ENV{MAGIC_INCLUDE_DIR}
    )

find_library( MAGIC_LIBRARY event
        PATHS $ENV{MAGIC_LIBRARY}
    )

mark_as_advanced( MAGIC_INCLUDE_DIR MAGIC_LIBRARY )

set( MAGIC_INCLUDE_DIRS ${MAGIC_INCLUDE_DIR} )
set( MAGIC_LIBRARIES    ${MAGIC_LIBRARY}     )

include( FindPackageHandleStandardArgs )
# handle the QUIETLY and REQUIRED arguments and set MAGIC_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args( MAGIC DEFAULT_MSG MAGIC_INCLUDE_DIR MAGIC_LIBRARY )

# vim: ts=4 sw=4 et
