
CC=gcc
INCLUDE=-I/usr/lib/jvm/java-8-openjdk-amd64/include/ -I/usr/lib/jvm/java-8-openjdk-amd64/include/linux/
CFLAGS=-c -fpic  -Ofast -fopenmp -march=native  $(INCLUDE)

omp:  interface_c_java_wrap.o fluid_omp.o
	$(CC) -shared interface_c_java_wrap.o  /usr/lib/gcc/x86_64-linux-gnu/6/libgomp.so fluid_omp.o -o libfluid.so
	javac *.java

fluid_omp.o: fluid_omp.c
	$(CC) $(CFLAGS) $<

interface_c_java_wrap.o:
	swig -java interface_c_java.swig
	$(CC) $(CFLAGS)  interface_c_java_wrap.c

nopti:  interface_c_java_wrap.o fluid_nopti.o
	$(CC) -shared interface_c_java_wrap.o  /usr/lib/gcc/x86_64-linux-gnu/6/libgomp.so fluid_nopti.o -o libfluid.so
	javac *.java
fluid_nopti.o: fluid_nopti.c
	$(CC) $(CFLAGS) $<


pinc:  interface_c_java_wrap.o fluid_pinc.o
	$(CC) -shared interface_c_java_wrap.o  /usr/lib/gcc/x86_64-linux-gnu/6/libgomp.so fluid_pinc.o -o libfluid.so
	javac *.java
fluid_pinc.o: fluid_pinc.c
	$(CC) $(CFLAGS) $<


muldiv:  interface_c_java_wrap.o fluid_muldiv.o
	$(CC) -shared interface_c_java_wrap.o  /usr/lib/gcc/x86_64-linux-gnu/6/libgomp.so fluid_muldiv.o -o libfluid.so
	javac *.java
fluid_muldiv.o: fluid_muldiv.c
	$(CC) $(CFLAGS) $<


inl:  interface_c_java_wrap.o fluid_inl.o
	$(CC) -shared interface_c_java_wrap.o  /usr/lib/gcc/x86_64-linux-gnu/6/libgomp.so fluid_inl.o -o libfluid.so
	javac *.java
fluid_inl.o: fluid_inl.c
	$(CC) $(CFLAGS) $<

java:
	javac *.java

run:
	LD_LIBRARY_PATH=$(shell pwd):$(LD_LIBRARY_PATH) appletviewer  -J"-Djava.security.policy=applet.policy" demo.html

debug:
	appletviewer -debug -J"-Djava.security.policy=applet.policy" demo.html

clean:
	rm -f *.o
	rm -f *.so
	rm -f fluid.java
	rm -f fluidJNI.java
	rm -f SWIGTYPE_p_float.java
	rm -f interface_c_java_wrap.c
	rm -f *.class
