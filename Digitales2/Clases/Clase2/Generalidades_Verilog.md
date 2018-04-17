# Generalidades de Verilog

Ejemplo

### Modulo no bloqueante

* Bien hecho
```verilog
module nonblocking(in,clk,out);
    input in, clk;
    output out;
    reg q1, q2, out;
    always @ posedge clk() begin
        q1 <= in;
        q2 <= q1;
        out <= q2;
    end
endmodule
```

#### Logica combinacional (serie)
B=A;\
C=B;\
D=C;

#### Logica Secuencial (paralelo)
B <= A;\
C <= B;\
D <= C;

-------------------------------

### Regs & wires

#### Wires
* Es un simple cable, puede ser de tamaño 1 bit o un bus
* Conecta entradas y salidas
* deben ser manejados, no pueden almacenar un valor
* no pueden estar al lado izquierdo (LHS) en las asignaciones de bloques always o initioal
*   Solo en un asign se puede poner a la izq
* Solo se pueden en logica combinacional

-----
Ejemplo Wires

```verilog
wire A,B,C,D,E      //wire-bit\
wire [8:0] Wide;    //wire 9-bit\
reg I;

assign A = B & C;
assign Wide = {4'b0,A,B,C,D,E} // 4'bo es el MSB y E el LSB\
always @(B or C) begin\
    I = B | C;\
end

mymodule mymodule_instance (    .in(D), Out(E)): //wire a la salida de un módulo
```
-----

#### Regs (secuencial y combinacional)
* pueden conectarse en la entrada de una instancia
* no se pueden conectar a la salida de una instancia
* se pueden utilizar como salidas en las declaraciones de un modulo
* no se pueden utilizar como entradas en la declaracion de un modulo
* unico tipo valido en las asignaciones a la izq de bloques always e initioal
* no se pueden utilizar a la izqa de un assign
* se pueden utilizar para crear flip flops en conjuto con un always@(posedge)
* se pueden utliizar para crear logica secuencial y combinacional.

Ejemplo

---------------
```verilog
wire A,B;
reg I,J,K; 
reg [8:0] Wide;

always @(A or B) begin
    I = A | B;
end
initial begin
    J <= 1'b1;
    #5
    @(posedge Clock);
    J <=1'b0'
end
always @(posedge Clock) begin
    K<=I;       \\ reg utilizado para crear un flop K que funciona con el flanco positivo 
end
```
------------------

### Errores

```verilog
wire Trigger, Passs;
reg A, C;
always @(*) begin
    A = 1'b0; // default 
    if (Trigger) begin
        A= Pass;
        C= Pass;
    end
end
```

Hay un error porque el registro C puede no tener valor si trigger no se activa, p ara arreglarlo hay que ponerle un default a C = 1'b0

---------------------

### Entradas Asincronicas
Cuando hay entradas asincronicas se puede crear metaestabilidad si no se matchea con el clk de uno. Por lo que para sincronizar ambas señales, se le debe pasar por 2 flip flops a la señal asincronica para sincronizarla.\
Para casos muy complejos se llegan a utilizar 3 flip flops
