#ifndef _pic14_h
#define _pic14_h

#if defined __16f627
#include <pic/pic16f627.h>
#elif defined __16f628
#include <pic/pic16f628.h>
#elif defined __16f628a
#include <pic/pic16f628a.h>
#elif defined __16f648a
#include <pic/pic16f648a.h>
#elif defined __GNUC__
// Ignore when calculating dependencies
#else
#error No processor or unknown processor specified
#endif

typedef unsigned char byte;

//unsigned short _moduint(unsigned short, unsigned short);
//unsigned short _divuint(unsigned short, unsigned short);

// No binary literals in sdcc, so add our own
#define BIN_BIT(value, bit, dec) \
  (((((unsigned long)(value##.0))/dec)&1 == 1)? (1<<bit) : 0)

#define BIN(value) \
( BIN_BIT(value,  0, 1) | \
  BIN_BIT(value,  1, 10) | \
  BIN_BIT(value,  2, 100) | \
  BIN_BIT(value,  3, 1000) | \
  BIN_BIT(value,  4, 10000) | \
  BIN_BIT(value,  5, 100000) | \
  BIN_BIT(value,  6, 1000000) | \
  BIN_BIT(value,  7, 10000000))

#endif
