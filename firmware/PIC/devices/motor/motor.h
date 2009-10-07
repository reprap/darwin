#ifndef _master_h
#define _master_h

#define __16f627
#include <pic/pic16f627.h>
#include "pic14.h"

void init2();
void processCommand();
void motorTick();

extern byte PWMPeriod;

#endif
