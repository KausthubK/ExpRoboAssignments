CXXFLAGS=$(GLOBAL_CXXFLAGS)
INCLUDE=`opencv-config --cxxflags` 
LIBS=`opencv-config --libs`

BINARIES=laserShow

all: $(BINARIES)

SRC = main.cpp

OBJS = $(SRC:.cpp=.o) 

depend:
	makedepend -D__linux__ -Y $(INCLUDE) *.cpp -f Makefile.dep &> /dev/null

clean:
	rm -f *.o $(BINARIES) *~ *.bak

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $<

laserShow: $(OBJS)
	$(CXX) $(CXXFLAGS)  -o $@ $(OBJS) $(LIBS)





