
AC_PREREQ(2.59)
AC_INIT([reprap-firmware-tools], [1.0], [bugs@reprap.org])
AM_INIT_AUTOMAKE([no-define])

unset CC
unset CFLAGS

AC_CONFIG_HEADER([config.h])

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_LN_S

# Checks for libraries.

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([fcntl.h stdlib.h sys/time.h termios.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STDBOOL
AC_C_CONST
AC_HEADER_TIME
AC_C_VOLATILE

# Checks for library functions.
AC_FUNC_SELECT_ARGTYPES
AC_CHECK_FUNCS([select strtol])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
