
bin_PROGRAMS = extruder1

AM_LDFLAGS=-L@top_builddir@/share -llibreprap.a

INCLUDES=-I@top_builddir@/share
CLEANFILES=*.asm *.lst *.p *.cod

extruder1_SOURCES = extruder1.c extruder2.c
extruder1_CFLAGS=-DPORT=9
