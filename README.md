
# Snap! CMake modules

This project provides base CMake modules for use with the `snapcpp` suite of
software libraries, servers, and utilities.

The modules include shell and Perl scripts as helpers to run various tests
on our source files (i.e. basic machine processed code reviews.)


# Todo

We want to remove all the `PATH_SUFFIXES` from our `find_path()` calls
because we should have them in the `#include ...` instead. These
should be used only if the library may be installed without that
suffix on some systems. In all other cases, it is a much better idea
to have the suffix in the include declaration.


# Bugs

Submit bug reports and patches on
[github](https://github.com/m2osw/snapcmakemodules/issues).


_This file is part of the [snapcpp project](https://snapwebsites.org/)._
