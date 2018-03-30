
CC=gcc
INCLUDE=-I/usr/lib/jvm/java-8-openjdk-amd64/include/ -I/usr/lib/jvm/java-8-openjdk-amd64/include/linux/
CFLAGS=-c -fpic -fopenmp -Ofast -march=native -mavx2 -finline-functions $(INCLUDE)

all: core java

core:  interface_c_java_wrap.o fluid.o
	$(CC) -shared interface_c_java_wrap.o /usr/lib/gcc/x86_64-linux-gnu/6/libgomp.so fluid.o -o libfluid.so

fluid.o: fluid.c
	$(CC) $(CFLAGS) $<

interface_c_java_wrap.o:
	swig -java interface_c_java.swig
	$(CC) $(CFLAGS)  interface_c_java_wrap.c

java:
	javac *.java

run:
	export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
	appletviewer  -J"-Djava.security.policy=applet.policy" demo.html

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
