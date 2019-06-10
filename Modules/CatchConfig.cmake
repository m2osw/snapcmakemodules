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
# Find the Catch.hpp header file
#
# This module defines:
#
# CATCH_INCLUDE_DIR     Where to find catch.hpp
# CATCH_FOUND           If false, do not try to use Catch.
#

set(CATCH_FOUND "NO")

find_path(CATCH_INCLUDE_DIR
        catch.hpp
    PATH_SUFFIXES
        catch
)

if(CATCH_INCLUDE_DIR)
    set(CATCH_FOUND "YES")
else(CATCH_INCLUDE_DIR)
    if(Catch_FIND_REQUIRED)
        message(SEND_ERROR "Could not find library Catch.")
    endif(Catch_FIND_REQUIRED)
endif(CATCH_INCLUDE_DIR)

# vim: ts=4 sw=4 et
