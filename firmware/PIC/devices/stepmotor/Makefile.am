

bin_PROGRAMS = stepmotorx stepmotory stepmotorz

AM_LDFLAGS=-L@top_builddir@/share -llibreprap.a

INCLUDES=-I@top_builddir@/share
CLEANFILES=*.asm *.lst *.p *.cod

stepmotorx_SOURCES = stepmotor1.c stepmotor2.c
stepmotorx_CFLAGS=-DPORT=2

stepmotory_SOURCES = stepmotor1.c stepmotor2.c
stepmotory_CFLAGS=-DPORT=3

stepmotorz_SOURCES = stepmotor1.c stepmotor2.c
stepmotorz_CFLAGS=-DPORT=4
