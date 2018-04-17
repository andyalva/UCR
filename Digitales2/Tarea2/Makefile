INPUT_01 = banco_de_pruebas.v
INPUT_02 = banco_de_pruebas_8b.v
INPUT_03 = banco_de_pruebas_16b.v
INPUT_04 = banco_de_pruebas_32b.v

TARGET_01 = Salida_4b.x
TARGET_02 = Salida_8b.x
TARGET_03 = Salida_16b.x
TARGET_04 = Salida_32b.x

CC = iverilog
RUN = vvp
FLAGS = #-Wall

all:
	$(CC) $(FLAGS) -o $(TARGET_01) $(INPUT_01)
	$(RUN) $(TARGET_01)
	gtkwave senales.vcd

8bits:
	$(CC) $(FLAGS) -o $(TARGET_02) $(INPUT_02)
	$(RUN) $(TARGET_02)
	gtkwave senales.vcd

16bits:
	$(CC) $(FLAGS) -o $(TARGET_03) $(INPUT_03)
	$(RUN) $(TARGET_03)
	gtkwave senales.vcd

32bits:
	$(CC) $(FLAGS) -o $(TARGET_04) $(INPUT_04)
	$(RUN) $(TARGET_04)
	gtkwave senales.vcd



clean:
	rm -f $(TARGET_01) $(TARGET_02) $(TARGET_03) $(TARGET_04) senales.vcd
