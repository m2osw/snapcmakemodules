################################################################################
#
# Copyright (c) 2024-2025  Made to Order Software Corp.  All Rights Reserved
#
# https://snapwebsites.org/
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
# File:         Modules/SnapRunUnitTestsConfig.cmake
# Object:       Run the unit tests of a project.
#

find_program(RUN_UNITTESTS_SCRIPT SnapRunUnitTests.sh PATHS ${CMAKE_MODULE_PATH})

################################################################################
# Add a target to run the unit tests of a project
#
# Usage: RunUnitTestsTarget(
#             PROJECT_NAME <name>
#             PROJECT_TEST_ARGS <arg1> <arg2> ... <argN>
#             [VERBOSE]
#        )
# where: <name> is the name you want to give this target; usually "rununittests"
#
# RunUnitTestsTarget() assumes that the unit test executable is named
# "unittest" and lives under the "${CMAKE_CURRENT_BINARY_DIR}/..." folder.
#
function(AddUnitTestsTarget)
    set(options
        VERBOSE
    )
    set(oneValueArgs
        PROJECT_NAME
    )
    set(multiValueArgs
        PROJECT_TEST_ARGS
    )
    cmake_parse_arguments(ARG
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    set(EXTRA_OPTIONS "")
    if(ARG_VERBOSE)
        set(EXTRA_OPTIONS "${EXTRA_OPTIONS} --verbose")
    endif()

    project(${ARG_PROJECT_NAME})

    set(UNITTEST_RAN ${PROJECT_BINARY_DIR}/${ARG_PROJECT_NAME})

    list(JOIN ARG_PROJECT_TEST_ARGS " " EXTRA_TEST_ARGS)
    add_custom_command(
        OUTPUT
            "${UNITTEST_RAN}"

        COMMAND
            ${RUN_UNITTESTS_SCRIPT}
                "--binary-dir" "${CMAKE_BINARY_DIR}"
                "--source-dir" "${CMAKE_SOURCE_DIR}"
                "--unittest-ran" "${UNITTEST_RAN}"
                "--extra-options" "${EXTRA_TEST_ARGS} ${EXTRA_OPTIONS}"

        WORKING_DIRECTORY
            ${CMAKE_BINARY_DIR}

        DEPENDS
            unittest
    )

    add_custom_target(${PROJECT_NAME}
        DEPENDS
            ${UNITTEST_RAN}
    )
endfunction()

# vim: ts=4 sw=4 et
