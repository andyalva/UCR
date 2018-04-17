#!/bin/bash

iverilog -o BancoPrueba.o BancoPrueba.v
vvp BancoPrueba.o
gtkwave alarma.vcd
#gtkwave senales.gtkw
