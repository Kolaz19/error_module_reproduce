VERSION ?= DEBUG


ifeq ($(VERSION),DEBUG)
DEF :=
DEBUG_FLAG = -g
else ifeq ($(VERSION),TEST)
DEF := -D UTEST
DEBUG_FLAG = -g
else ifeq ($(VERSION),RELEASE)
DEF := -D NDEBUG
DEBUG_FLAG =
else
$(error Wrong version/macro ($(VERSION)) set)
endif

CC = gcc
CC_WIN = x86_64-w64-mingw32-gcc

OBJ_DIR = ./object_files/
INCLUDE_DIRS = -I./include -I./src
LIB_DIR = -L ./lib

C_FLAGS = $(INCLUDE_DIRS) $(DEBUG_FLAG) -Wall -Wextra -Wconversion -std=gnu99 -fdiagnostics-color=always -pedantic

C_FILES := $(wildcard src/*.c) $(wildcard src/**/*.c)

OBJ_FILES_LIN = $(patsubst src/%.c, $(OBJ_DIR)%_lin.o, $(C_FILES))
OBJ_FILES_WIN = $(patsubst src/%.c, $(OBJ_DIR)%_win.o, $(C_FILES))

LINKERS_LIN = $(LIB_DIR)  
LINKERS_WIN = $(LIB_DIR) -lws2_32

.PHONY: build lin win clean run

build: lin

lin: main

main: $(OBJ_FILES_LIN)
	$(CC) $(C_FLAGS) -o main $(OBJ_FILES_LIN) $(LINKERS_LIN)

$(OBJ_FILES_LIN): $(OBJ_DIR)%_lin.o: src/%.c
	@mkdir -p $(@D) #Create directory when needed
	$(CC) $(DEF) -c $(C_FLAGS) $(DEBUG_FLAG) $< -o $@

win: main.exe

main.exe: $(OBJ_FILES_WIN)
	$(CC_WIN) $(C_FLAGS) -static -o main $(OBJ_FILES_WIN) $(LINKERS_WIN)

$(OBJ_FILES_WIN): $(OBJ_DIR)%_win.o: src/%.c
	@mkdir -p $(@D) #Create directory when needed
	$(CC_WIN) $(DEF) -c $(C_FLAGS) $< -o $@

clean: 
	rm -f main.exe main
	rm -rf $(OBJ_DIR)*

run: 
	./main
