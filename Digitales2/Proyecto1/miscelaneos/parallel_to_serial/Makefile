INPUT = test_bench.v
TARGET = parallel_serial_cond.x

CC = iverilog
RUN = vvp
FLAGS = -o

all:
	$(CC) $(FLAGS) $(TARGET) $(INPUT)
	$(RUN) $(TARGET)

clean:
	rm -rf $(TARGET) *.tcl