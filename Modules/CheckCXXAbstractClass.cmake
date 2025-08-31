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
# - Check whether given C++ source fails compiling because of an abstract
#   type
#
# CHECK_CXX_ABSTRACT_CLASS(<code> <var>)
#  <code>       - source code to try to compile, must define 'main'
#  <var>        - variable to store whether the source code compiled
#
# The following variables may be set before calling this macro to
# modify the way the check is run:
#
#  CMAKE_REQUIRED_FLAGS       = string of compile command line flags
#  CMAKE_REQUIRED_DEFINITIONS = list of macros to define (-DFOO=bar)
#  CMAKE_REQUIRED_INCLUDES    = list of include directories
#

#=============================================================================
# Based on the Kitware, Inc. CheckCXXSourceCompiles.cmake
#=============================================================================



macro(CHECK_CXX_ABSTRACT_CLASS SOURCE VAR)
  if("${VAR}" MATCHES "^${VAR}$")
    set(MACRO_CHECK_FUNCTION_DEFINITIONS
      "-D${VAR} ${CMAKE_REQUIRED_FLAGS}")
    if(CMAKE_REQUIRED_INCLUDES)
      set(CHECK_CXX_SOURCE_COMPILES_ADD_INCLUDES
        "-DINCLUDE_DIRECTORIES:STRING=${CMAKE_REQUIRED_INCLUDES}")
    else()
      set(CHECK_CXX_SOURCE_COMPILES_ADD_INCLUDES)
    endif()
    file(WRITE "${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/src.cxx"
      "${SOURCE}\n")

    message(STATUS "Performing Test ${VAR}")
    try_compile(${VAR}
      ${CMAKE_BINARY_DIR}
      ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/src.cxx
      COMPILE_DEFINITIONS ${CMAKE_REQUIRED_DEFINITIONS}
      CMAKE_FLAGS -DCOMPILE_DEFINITIONS:STRING=${MACRO_CHECK_FUNCTION_DEFINITIONS}
      "${CHECK_CXX_SOURCE_COMPILES_ADD_INCLUDES}"
      OUTPUT_VARIABLE OUTPUT)

    # If the compile succeeds, then it is a failure (althgough the link should
    # pretty much always fail?!)
    if(NOT ${VAR})
      if("${OUTPUT}" MATCHES "cannot allocate an object of abstract type")
      elseif("${OUTPUT}" MATCHES "because the following virtual functions are pure within")
      elseif("${OUTPUT}" MATCHES "error: .* is protected")
      elseif("${OUTPUT}" MATCHES "error: .* is private")
      else()
        message("+++ compiler failed output is: +++\n${OUTPUT}+++ end of failed output +++")
        set(${VAR} 1)
      endif()
    endif()

    if(${VAR})
      set(${VAR} "" CACHE INTERNAL "Test ${VAR}")
      file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
        "Performing C++ SOURCE FILE Test ${VAR} succeeded compiling the instantiation of an abstract class or did not get a valid error to prove that it is abstract:\n"
        "${OUTPUT}\n"
        "Source file was:\n${SOURCE}\n")
      message(FATAL_ERROR "Performing Test ${VAR} - Failed, compilation succeeded or no error meant that the class is abstract")
    else()
      # So... the compilation failed, make sure it says one of:
      # "cannot allocate an object of abstract type"
      # "because the following virtual functions are pure within"
      message(STATUS "Performing Test ${VAR} - Success")
      set(${VAR} "" CACHE INTERNAL "Test ${VAR}")
      file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
        "Performing C++ SOURCE FILE Test ${VAR} failed as expected with the following output:\n"
        "${OUTPUT}\n"
        "Source file was:\n${SOURCE}\n")
    endif()
  endif()
endmacro()

# vim: ts=2 sw=2 et
