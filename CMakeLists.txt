# Copyright (c) 2011-2025  Made to Order Software Corp.  All Rights Reserved
#
# http://snapwebsites.org/project/snapcmakemodules
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

cmake_minimum_required(VERSION 3.10.2)

project(snapCMakeModules)

string(REPLACE "/usr/" "" SNAP_CMAKE_INSTALL_DIR "${CMAKE_ROOT}")

install(
    FILES
        Modules/CheckCXXAbstractClass.cmake

    DESTINATION
        ${SNAP_CMAKE_INSTALL_DIR}/Modules
)

set(MODULES_LIST
    DumpCMakeVariables
    LibQREncode
    Magic
    SnapBuild
    SnapCMakeModules
    SnapDoxygen
    SnapTestRunner
)

foreach(_module ${MODULES_LIST})
    install(
        FILES
            Modules/${_module}Config.cmake

        DESTINATION
            share/cmake/${_module}
    )
endforeach()

file(GLOB SCRIPTS Modules/*.sh Modules/*.pl)
install(
    PROGRAMS
        ${SCRIPTS}

    DESTINATION
        bin
)

# vim: ts=4 sw=4 et
