#
# From
#   https://stackoverflow.com/questions/9298278/cmake-print-out-all-accessible-variables-in-a-script
#

################################################################################
# Print out all the CMake variable at the point it gets called.
#
# Usage: DumpCMakeVariables([pattern])
#
#        where `pattern` is an optional regex used to match variable names to
#        limit the output.
#
function(DumpCMakeVariables)
    get_cmake_property(_variableNames VARIABLES)
    list(SORT _variableNames)
    foreach(_variableName ${_variableNames})
        if(ARGV0)
            unset(MATCHED)
            string(REGEX MATCH ${ARGV0} MATCHED ${_variableName})
            if(NOT MATCHED)
                continue()
            endif()
        endif()
        message(STATUS "${_variableName}=${${_variableName}}")
    endforeach()
endfunction()

# vim: ts=4 sw=4 et
