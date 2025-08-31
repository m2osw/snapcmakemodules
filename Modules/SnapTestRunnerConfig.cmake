################################################################################
#
# Copyright (c) 2024-2025  Made to Order Software Corp.  All Rights Reserved
#
# https://snapwebsites.org/
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
