# Sintesis

Clase 18 de Abril

## Sintesis automática con Yosis


```verilog
module sysANDGate
(output f,
input a, b);
and A(f, a, b);
endmodule
```

read_verilog sysANDGate.v\
proc\
opt (optimice) \
techmap (usa una libreria en especifico hecha en verilog) \
opt\
show -lib cmos_cells.v\

Crea un nand con las librerias de verilog\

read_verilog sysANDGate.v\
proc\
opt (optimice) \
techmap (usa una libreria en especifico hecha en verilog) \
opt\
abc (sintesis de la parte combinacional) -liberty cmos_cells.lib
show -lib cmos_cells.v\

Cambia el nand con 2 nots hacia una nor