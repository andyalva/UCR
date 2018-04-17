CC = g++
OPT = -O3
OPT = -g
WARN = -Wall
ERR = -Werror

CFLAGS = $(OPT) $(WARN) $(ERR) $(INC) $(LIB)

SIM_SRC = main.cc cache.cc 

SIM_OBJ = main.o cache.o 

all: mesi_cache
	@echo "Compilation Done ---> nothing else to make :) "

mesi_cache: $(SIM_OBJ)
	$(CC) -o mesi_cache $(CFLAGS) $(SIM_OBJ) -lm
	
.cc.o:
	$(CC) $(CFLAGS)  -c $*.cc

clean:
	rm -f *.o mesi_cache

clobber:
	rm -f *.o


