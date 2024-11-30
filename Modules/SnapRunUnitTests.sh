#!/bin/bash -e
#
# This script runs the `unittest` command for the custom command created
# by the SnapTestRunnerConfig.cmake module.
#
# The parameters to the script are defined by the --help command line option.
#
################################################################################
#
# Copyright (c) 2024  Made to Order Software Corp.  All Rights Reserved
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

EXTRA_OPTIONS=
while test -n "$1"
do
	case "$1" in
	"--help"|"-h")
		echo "Usage: `basename $0` --opts"
		echo "where --opts are:"
		echo "  --binary-dir <dir>         path to this project top binary directory"
		echo "  --extra-options <opts>     a set of additional options"
		echo "  --help | -h                print out this help screen"
		echo "  --source-dir <dir>         path to this project top source directory"
		echo "  --unittest-ran <filename>  name of the dependency to generate on success (usually the PROJECT_NAME)"
		exit 1
		;;

	"--binary-dir")
		shift
		BINARY_DIR="$1"
		shift
		;;

	"--extra-options")
		shift
		EXTRA_OPTIONS="$1"
		if test -n "${EXTRA_OPTIONS}"
		then
			shift
		fi
		;;

	"--source-dir")
		shift
		SOURCE_DIR="$1"
		shift
		;;

	"--unittest-ran")
		shift
		UNITTEST_RAN="$1"
		shift
		;;

	*)
		echo "error: unknown command line option \"$1\"."
		exit 1;

	esac
done

if test -z "${BINARY_DIR}"
then
	echo "error: the --binary-dir option is mandatory and cannot be an empty string."
	exit 1
fi

if test -z "${SOURCE_DIR}"
then
	echo "error: the --source-dir option is mandatory and cannot be an empty string."
	exit 1
fi

if test -z "${UNITTEST_RAN}"
then
	echo "error: the --unittest-ran option is mandatory and cannot be an empty string."
	exit 1
fi

UNITTEST="tests/unittest"
if test ! -x "${UNITTEST}"
then
	echo "error: no tests/unittest executable found."
	exit 1
fi

# make sure the temporary directory exists
#
mkdir -p "${BINARY_DIR}/tmp"

# find the distribution directory (where things get installed)
#
DIST_DIR="${BINARY_DIR}"
while ! test -d "${DIST_DIR}/dist"
do
	DIST_DIR=`dirname "${DIST_DIR}"`
	if test -z "${DIST_DIR}" -o "${DIST_DIR}" = "/" -o "${DIST_DIR}" = "." -o -d "${DIST_DIR}/BUILD"
	then
		echo "error: distribution directory not found starting from \"${BINARY_DIR}\"."
		exit 1
	fi
done
DIST_DIR="${DIST_DIR}/dist"

# run all the unit tests
"${UNITTEST}" \
	--colour-mode ansi \
	--tmp-dir "${BINARY_DIR}/tmp" \
	--binary-dir "${BINARY_DIR}" \
	--dist-dir "${DIST_DIR}" \
	--source-dir "${SOURCE_DIR}" \
	--progress \
	${EXTRA_OPTIONS} \
		> tests/unittest.log 2>&1

# it worked, "generate the output" (make target dependency)
#
touch "${UNITTEST_RAN}"
