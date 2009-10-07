
bin_PROGRAMS = extruder0

AM_LDFLAGS=-L@top_builddir@/share -llibreprap.a

INCLUDES=-I@top_builddir@/share
CLEANFILES=*.asm *.lst *.p *.cod

extruder0_SOURCES = extruder1.c extruder2.c
extruder0_CFLAGS=-DPORT=8

