AC_PREREQ(2.59)
AC_INIT([reprap-firmware], [1.0], [bugs@reprap.org])
AM_INIT_AUTOMAKE

cross_compiling=yes
enable_dependency_tracking=no

AC_CONFIG_HEADER([config.h])

# Checks for programs.

AC_CHECK_PROG(GPASMEXISTS, gpasm, true, false)
if test $GPASMEXISTS != true; then
  AC_MSG_FAILURE([gpasm is required])
fi

AC_CHECK_PROG(GPLIBEXISTS, gplib, true, false)
if test $GPLIBEXISTS != true; then
  AC_MSG_FAILURE([gplib is required])
fi

AC_CHECK_PROG(SDCCEXISTS, sdcc, true, false)
if test $SDCCEXISTS != true; then
  AC_MSG_FAILURE([sdcc is required])
fi

export CC=sdcc

export CFLAGS="-mpic14 -p16f648a -D__16f648a -Wl-m"

#echo -n "checking sdcc version... " 
#export SDCCVERSION=`sdcc -v 2>&1 | sed 's/.*#\([0-9]*\).*$/\1/'`
#echo $SDCCVERSION
#if test $SDCCVERSION != 1183; then
#  AC_MSG_FAILURE([sdcc must currently be version 1183.  Try --enable-sdcc=cvs to build a local version of sdcc.  See --help for more details and build options.])
#fi

# Standard autoconf tests can't deal with extraneous tests, so
# give it the answer
m4_define([_AC_COMPILER_EXEEXT_DEFAULT],[ac_exeext=.hex])
m4_define([_AC_COMPILER_EXEEXT_O],[ac_cv_exeext=.hex])

AC_PROG_CC([sdcc])

#AC_LANG_CONFTEST([AC_LANG_SOURCE([[xxx]])])

#AC_RUN_IFELSE([AC_LANG_SOURCE([[int main(){}]])],
#  AC_DEFINE(X,Y),
#  AC_MSG_FAILURE([Failed])) 

AC_C_VOLATILE

AC_CHECK_HEADER([pic/pic16f628.h])

# We don't want to ranlib because gplib does it for us
AC_CHECK_TOOL(RANLIB, echo)

AC_PROG_LN_S

AC_CONFIG_SUBDIRS([tools])

AC_CONFIG_FILES([Makefile share/Makefile devices/Makefile devices/stepmotor/Makefile devices/extruder_0/Makefile devices/extruder_1/Makefile ])
AC_OUTPUT
AM_PROG_CC_C_O

