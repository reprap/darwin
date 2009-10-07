TARGET=iobox

SOURCES=iobox1.c iobox2.c

include ../../picmake.inc

CFLAGS += -DPORT=50

$(BUILDDIR)/$(TARGET).hex:	$(OBJS) $(PICDEPS)
	cd $(BUILDDIR) && gplink -m -c -o $(TARGET).hex $(SOURCES:.c=.o) $(LDFLAGS)
	perl $(BASEDIR)/tools/checkmap $(BUILDDIR)/$(TARGET).map

include ../../make.inc
include $(SOURCES:.c=.dep)
