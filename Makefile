# compiler
CC=gcc
# linker
LD=gcc
# optimisation
OPT=-O2
# warnings
WARN=-Wall -Wextra
# standards
STD=-ansi -pedantic
# pthread
PTHREAD=-pthread

CCFLAGS = $(DEBUG) $(WARN) $(PTHREAD) $(STD) $(OPT) -pipe `pkg-config --cflags openal SPTK gtk+-3.0`
LDFLAGS = $(PTHREAD) -export-dynamic `pkg-config --libs openal SPTK gtk+-3.0`

SRCS = $(wildcard *.c) $(wildcard ./*/*.c)
OBJECTS = $(patsubst %.c, %.o, $(SRCS))

TARGET = September

.PHONY: default all clean

default: $(TARGET)

all: default

%.o: %.c
	$(CC) $(CCFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(LD) $(OBJECTS) $(LDFLAGS) -o $@

clean:
	$(RM) *.o
	$(RM) ./*/*.o
	$(RM) $(TARGET)
