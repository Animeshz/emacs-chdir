EMACS_ROOT ?= ../..
EMACS ?= emacs

CC      = gcc
LD      = gcc
CPPFLAGS = -I$(EMACS_ROOT)/src
CFLAGS = -std=gnu99 -ggdb3 -Wall -fPIC $(CPPFLAGS)

all: chdir-core.so

chdir-core.so: chdir-core.o
	$(LD) -shared $(LDFLAGS) -o $@ $^ $(PCRE_LIBS)

chdir-core.o: chdir-core.c
	$(CC) $(CFLAGS) -c -o $@ $<
