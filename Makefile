CC = gcc
CFLAGS = -Wall -I./c-logger/build/install/install/include/
LDFLAGS = -L./c-logger/build/install/install/lib/ -Wl,-rpath,./c-logger/build/install/install/lib/
LIBS = -llogger

all: install nwd_program

install: 
	./install.sh

nwd_program:
	$(CC) -o nwd_program main.c nwd.c $(CFLAGS) $(LDFLAGS) $(LIBS)

clean:
	rm -f *.o nwd_program
