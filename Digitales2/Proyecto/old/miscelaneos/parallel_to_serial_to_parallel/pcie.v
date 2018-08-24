// Incluir todos los archivos de los modulos

`include "../parallel_to_serial/parallel_serial.v"
`include "../serial_to_parallel/serial_parallel.v"
// Union de modulos de manera estructural

module pcie(
		input RESET,
		input CLK,
		input Valid,
		output [7:0] data
		);

	// Wires de conexion
	wire CLK;
	wire VALID;
	wire [7:0] data0;
	wire [7:0] paralelo0;

	// Paralelo a Serial TX (4 lineas, 4 modulos)
	parallel_serial_cond serial0 (data, CLK, RESET, Valid, dataserial0);
	// Serial a Paralelo RX (4 lineas, 4 modulos)
	serial_parallel_cond parallel0 (dataserial0, CLK, RESET, paralelo0);
	
	
endmodule
