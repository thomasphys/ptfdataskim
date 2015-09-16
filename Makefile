# Makefile

CXXFLAGS = -g -O2 -Wall -Wuninitialized -I$(ROOTANASYS)/include

# optional ZLIB library

CXXFLAGS += -DHAVE_ZLIB

# ROOT libraries

ifdef ROOTSYS
#ROOTLIBS  = -L$(ROOTSYS)/lib $(shell $(ROOTSYS)/bin/root-config --libs)  -lXMLParser -lThread
ROOTGLIBS = -L$(ROOTSYS)/lib $(shell $(ROOTSYS)/bin/root-config --glibs) -lXMLParser -lThread
ROOTANASLIBS = -L$(ROOTANASYS)/lib/ 
#RPATH    += -Wl,-rpath,$(ROOTSYS)/lib
CXXFLAGS += -DHAVE_ROOT $(shell $(ROOTSYS)/bin/root-config --cflags)
endif

# optional MIDAS libraries

ifdef MIDASSYS
MIDASLIBS = $(MIDASSYS)/linux/lib/libmidas.a -lutil -lrt
CXXFLAGS += -DHAVE_MIDAS -DOS_LINUX -Dextname -I$(MIDASSYS)/include

UNAME=$(shell uname)
ifeq ($(UNAME),Darwin)
CXXFLAGS += -DOS_LINUX -DOS_DARWIN
MIDASLIBS = $(MIDASSYS)/darwin/lib/
RPATH=
endif

endif

ALL:= 
OBJS:=
LIBS:=
ifdef ROOTSYS
All  += PTFDict.cc
ALL  += ptfdataskim
OBJS += SkimSingle.o
OBJS += PTFDict.o
endif

ifdef ROOTSYS
LIBS     += -lrootana
LIBS     += -lmidas
endif


all: $(ALL)

ptfdataskim: ptfdataskim.o $(OBJS)  
	$(CXX) -o $@ $(CXXFLAGS) $^ $(MIDASLIBS) $(ROOTANASLIBS) $(LIBS) $(ROOTGLIBS) -lm -lz -lpthread $(RPATH)

%.o: %.cc
	$(CXX) $(CXXFLAGS) $(MIDASLIBS) $(ROOTANASLIBS) $(LIBS) $(ROOTGLIBS) -c $<
    
PTFDict.cc:
	$(ROOTSYS)/bin/rootcint -f PTFDict.cc -c $(INC) Pulse.hh ptfEvent.hh LinkDef.h

dox:
	doxygen

clean::
	-rm -f *.o *.a *.exe $(ALL) PTFDict.cc PTFDict.h

# end
