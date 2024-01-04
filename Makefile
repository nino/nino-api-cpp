CFLAGS = -Wall -g -std=c++20 -Wextra -pedantic
LIBS = $(shell pkg-config --cflags --libs libhttpserver) -I./libhttpserver/src \
			 $(shell pkg-config --cflags --libs libssl libcrypto )

FILES = main.cpp last_year.cpp

all:
	clang++ $(CFLAGS) $(LIBS) -o main $(FILES)
