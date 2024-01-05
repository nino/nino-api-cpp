CFLAGS = -Wall -g -std=c++20 -Wextra -pedantic
LIBS = $(shell pkg-config --cflags --libs libhttpserver) -I./libhttpserver/src \
       $(shell pkg-config --cflags --libs libssl libcrypto pugixml)

SRC = main.cpp last_year.cpp http.cpp
OBJ = $(SRC:.cpp=.o)
DEP = $(OBJ:.o=.d)
EXEC = main

# New: Define build directory
BUILD_DIR = ./build

# Adjusted: Prefix paths
OBJ := $(addprefix $(BUILD_DIR)/,$(OBJ))
DEP := $(addprefix $(BUILD_DIR)/,$(DEP))
EXEC := $(BUILD_DIR)/$(EXEC)

.PHONY: all clean setup

all: setup $(EXEC)

# New: Ensure build directory exists
setup:
	mkdir -p $(BUILD_DIR)

# Adjusted: Rule for linking the final executable
$(EXEC): $(OBJ)
	clang++ $(CFLAGS) -o $@ $^ $(LIBS)

# Adjusted: Rule for creating object files
$(BUILD_DIR)/%.o: %.cpp
	clang++ $(CFLAGS) -c $< -o $@

# Adjusted: Include dependency files
-include $(DEP)

# Adjusted: Rule for generating dependency files
$(BUILD_DIR)/%.d: %.cpp
	@clang++ $(CFLAGS) -MM $< > $@
	@mv -f $@ $@.tmp
	@sed -e 's|.*:|$(BUILD_DIR)/$*.o:|' < $@.tmp > $@
	@sed -e 's/.*://' -e 's/\\$$//' < $@.tmp | fmt -1 | \
	  sed -e 's/^ *//' -e 's/$$/:/' >> $@
	@rm -f $@.tmp

clean:
	rm -rf $(BUILD_DIR)
