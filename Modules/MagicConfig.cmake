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
# - Try to find the magic library and headers
#
# The magic library is used to check the type of a file from its contents.
#
# Once done this will define
#
# MAGIC_FOUND        - System has Magick
# MAGIC_INCLUDE_DIRS - The magic include directories
# MAGIC_LIBRARIES    - The libraries needed to use magic
# MAGIC_DEFINITIONS  - Compiler switches required for using magic

#find_file(MAGIC magic.h)
#if(${MAGIC} STREQUAL "MAGIC-NOTFOUND")
#    message(FATAL_ERROR "Please install libmagic-dev!")
#endif()
#get_filename_component(MAGIC_INCLUDE_PATH ${MAGIC} PATH)
#
#find_library(MAGIC_LIBRARY magic
#    PATHS $ENV{MAGIC_LIBRARY}
#)
#if(${MAGIC_LIBRARY} STREQUAL "MAGIC_LIBRARY-NOTFOUND")
#    message(FATAL_ERROR "Please install libmagic-dev!")
#endif()



find_path(MAGIC_INCLUDE_DIR magic.h
    PATHS $ENV{MAGIC_INCLUDE_DIR}
)

find_library(MAGIC_LIBRARY magic
    PATHS $ENV{MAGIC_LIBRARY}
)

mark_as_advanced(MAGIC_INCLUDE_DIR MAGIC_LIBRARY)

set(MAGIC_INCLUDE_DIRS ${MAGIC_INCLUDE_DIR})
set(MAGIC_LIBRARIES    ${MAGIC_LIBRARY}    )

# handle the QUIETLY and REQUIRED arguments and set MAGIC_FOUND to TRUE
# if all listed variables are TRUE
#
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    Magic
    DEFAULT_MSG
    MAGIC_INCLUDE_DIR
    MAGIC_LIBRARY
)

# vim: ts=4 sw=4 et
