<?php
# Display this directory to users
# (code used to display test results)
#
# Copyright (c) 2011-2025  Made to Order Software Corp.  All Rights Reserved
#
# https://snapwebsites.org/project/snapcmakemodules
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


function out($d, $file, $label)
{
    $filename = $d . "/" . $file;
    if(file_exists($filename))
    {
        echo "<td><a href=\"", $d, "/", $file, "\">", $label, "</a></td>";
    }
    else
    {
        echo "<td>&mdash;</td>";
    }
}


$dir = glob("@PROJECT_NAME@*");

echo "<html><head><title>@PROJECT_NAME@ coverage</title></head>",
    "<body><h1>@PROJECT_NAME@ coverage</h1>",
    "<table border=\"1\" cellpadding=\"10\" cellspacing=\"0\">",
    "<thead><tr>",
        "<th>Coverage</th>",
        "<th>Profiling</th>",
        "<th>CMake</th>",
        "<th>Build</th>",
        "<th>Test</th>",
        "<th>Statistics</th>",
    "</tr><tbody>";

foreach($dir as $d)
{
    echo "<tr>";

        echo "<td><a href=\"", $d, "\">", $d, "</a></td>";

        out($d, "profiler.html", "gprof");
        out($d, "cmake_log.html", "log");
        out($d, "build_log.html", "log");
        out($d, "test_log.html", "log");
        out($d, "statistics.html", "stats");

    echo "</tr>";
}

echo "</tbody></table><p><a href=\"..\">Back to list of projects</a></body></html>";

# vim: ts=4 sw=4 et
