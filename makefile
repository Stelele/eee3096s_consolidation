CC = arm-linux-gnueabihf-gcc
CFLAGS = -O1

PROG = bin/*
OBJS = obj/*

default:
	mkdir -p bin obj
	$(CC) $(CFLAGS) -c src/samp1.s -o obj/samp1.o  
	$(CC) $(CFLAGS) -c src/main.c -o obj/main.o
	$(CC) $(CFLAGS) -c src/blips.s -o obj/blips.o 
	$(CC) -o bin/main obj/main.o obj/samp1.o obj/blips.o $(CFLAGS)

run:
	bin/main

clean:
	rm -rf $(PROG) $(OBJS)