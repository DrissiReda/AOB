
CC=gcc
INCLUDE=-I/usr/lib/jvm/java-8-openjdk-amd64/include/ -I/usr/lib/jvm/java-8-openjdk-amd64/include/linux/
TCFLAGS=-fpic  -Ofast -fopenmp -march=skylake -fprefetch-loop-arrays -Winline -msse4  $(INCLUDE)
CFLAGS=-c $(TCFLAGS)
GOMP=/usr/lib/gcc/x86_64-linux-gnu/6/libgomp.so

fin:  interface_c_java_wrap.o fluid.o
	$(CC) -shared interface_c_java_wrap.o  $(GOMP) fluid.o -o libfluid.so
	javac *.java

fluid.o: fluid.c
	$(CC) $(CFLAGS) $<

omp:  interface_c_java_wrap.o fluid_omp.o
	$(CC) -shared interface_c_java_wrap.o  $(GOMP) fluid_omp.o -o libfluid.so
	javac *.java

fluid_omp.o: fluid_omp.c
	$(CC) $(CFLAGS) $<

interface_c_java_wrap.o:
	swig -java interface_c_java.swig
	$(CC) $(CFLAGS)  interface_c_java_wrap.c

nopti:  interface_c_java_wrap.o fluid_nopti.o
	$(CC) -shared interface_c_java_wrap.o  $(GOMP) fluid_nopti.o -o libfluid.so
	javac *.java
fluid_nopti.o: fluid_nopti.c
	$(CC) $(CFLAGS) $<


pinc:  interface_c_java_wrap.o fluid_pinc.o
	$(CC) -shared interface_c_java_wrap.o  $(GOMP) fluid_pinc.o -o libfluid.so
	javac *.java
fluid_pinc.o: fluid_pinc.c
	$(CC) $(CFLAGS) $<


muldiv:  interface_c_java_wrap.o fluid_muldiv.o
	$(CC) -shared interface_c_java_wrap.o  $(GOMP) fluid_muldiv.o -o libfluid.so
	javac *.java
fluid_muldiv.o: fluid_muldiv.c
	$(CC) $(CFLAGS) $<


inl:  interface_c_java_wrap.o fluid_inl.o
	$(CC) -shared interface_c_java_wrap.o  $(GOMP) fluid_inl.o -o libfluid.so
	javac *.java
fluid_inl.o: fluid_inl.c
	$(CC) $(CFLAGS) $<

java:
	javac *.java

run:
	LD_LIBRARY_PATH=$(shell pwd):$(LD_LIBRARY_PATH) appletviewer  -J"-Djava.security.policy=applet.policy" demo.html

debug:
	appletviewer -debug -J"-Djava.security.policy=applet.policy" demo.html
test:
	$(CC) $(TCFLAGS) -g -floop-unroll-and-jam fluid_test.c -o testing
clean:
	rm -f *.o
	rm -f *.so
	rm -f fluid.java
	rm -f fluidJNI.java
	rm -f SWIGTYPE_p_float.java
	rm -f interface_c_java_wrap.c
	rm -f *.class
