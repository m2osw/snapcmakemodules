
* The python script used to generate the .svg with the dependency tree uses
  os.system() to run dot. This leaks really very badly, as in, stdout is
  changed for the entire application (really stupid implementation if you
  ask me, but there may be some useful needs for such?!) It can be fixed
  using the popen() function instead.

  See: https://stackoverflow.com/questions/21428622/clear-stdout-in-python-cgi-after-os-system

