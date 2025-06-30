CC = gcc
CFLAGS = -Wall -std=c99 -g
TARGET = routing_sim
SOURCES = src/main.c src/bgp.c src/ospf.c

.PHONY: all clean debug test

all: $(TARGET)

$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCES)

debug: CFLAGS += -DDEBUG -g3
debug: $(TARGET)

test: $(TARGET)
	./scripts/run_tests.sh

benchmark: $(TARGET)
	./scripts/benchmark.sh

clean:
	rm -f $(TARGET) *.json *.png *.txt

install: $(TARGET)
	sudo cp $(TARGET) /usr/local/bin/

help:
	@echo "Targets:"
	@echo "  all       - Build simulator"
	@echo "  test      - Run test suite"
	@echo "  benchmark - Run performance tests"
	@echo "  clean     - Remove build files"
	@echo "  debug     - Build with debug info"
