CFLAGS = -Wall -g -std=c++20 -Wextra -pedantic
LIBS = $(shell pkg-config --libs libhttpserver --cflags libhttpserver) -I./libhttpserver/src

FILES = main.cpp last_year.cpp

all:
	clang++ $(CFLAGS) $(LIBS) -o main $(FILES)
