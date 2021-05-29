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
# - Try to find log4cplus
#
# Once done this will define
#
# LOG4CPLUS_FOUND         - System has log4cplus
# LOG4CPLUS_INCLUDE_DIRS  - The log4cplus include directories
# LOG4CPLUS_LIBRARIES     - The libraries needed to use log4cplus
# LOG4CPLUS_DEFINITIONS  - Compiler switches required for using log4cplus (none)

find_path( LOG4CPLUS_INCLUDE_DIR log4cplus/logger.h
                           HINTS $ENV{LOG4CPLUS_INCLUDE_DIR}
                   PATH_SUFFIXES log4cplus
)
find_library( LOG4CPLUS_LIBRARY log4cplus
                          HINTS $ENV{LOG4CPLUS_LIBRARY}
)
mark_as_advanced( LOG4CPLUS_INCLUDE_DIR LOG4CPLUS_LIBRARY )

set( LOG4CPLUS_INCLUDE_DIRS ${LOG4CPLUS_INCLUDE_DIR} )
set( LOG4CPLUS_LIBRARIES    ${LOG4CPLUS_LIBRARY}     )

include( FindPackageHandleStandardArgs )
# handle the QUIETLY and REQUIRED arguments and set LOG4CPLUS_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args( log4cplus DEFAULT_MSG LOG4CPLUS_INCLUDE_DIR LOG4CPLUS_LIBRARY )

# vim: ts=4 sw=4 et
