CXXFLAGS=$(GLOBAL_CXXFLAGS)
INCLUDE=`opencv-config --cxxflags` -I /usr/local/src/cvs/Vision/camera/src
LIBS=`opencv-config --libs` -lhighgui -lcamera -l raw1394 -ldc1394_control

BINARIES=display_edges

all: $(BINARIES)

SRC = display_edges.cpp

OBJS = $(SRC:.cpp=.o) 

depend:
	makedepend -D__linux__ -Y $(INCLUDE) *.cpp -f Makefile.dep &> /dev/null

clean:
	rm -f *.o $(BINARIES) *~ *.bak

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $<

display_edges: $(OBJS)
	$(CXX) $(CXXFLAGS)  -o $@ $(OBJS) $(LIBS)





