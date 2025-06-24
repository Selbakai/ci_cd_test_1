# Makefile for C project
CC=gcc
CFLAGS=-Wall -Wextra -std=c99 -pedantic
TARGET=main
SOURCES=main.c

# Default target
all: $(TARGET)

# Build the main executable
$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCES)

# Clean build artifacts
clean:
	rm -f $(TARGET) $(TARGET).exe *.o

# Run the program
run: $(TARGET)
	./$(TARGET)

# Debug build
debug: CFLAGS += -g -DDEBUG
debug: $(TARGET)

# Release build
release: CFLAGS += -O2 -DNDEBUG
release: $(TARGET)

.PHONY: all clean run debug release
